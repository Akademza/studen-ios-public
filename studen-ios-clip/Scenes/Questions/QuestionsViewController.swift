//
//  QuestionsViewController.swift
//  pifagor-ai-ios
//
//  Created by Andreas on 01.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QuestionsDisplayLogic: AnyObject {
    func displayData(viewModel: Questions.Model.ViewModel.ViewModelData)
}

class QuestionsViewController: UIViewController {
    
    var interactor: QuestionsBusinessLogic?
    var router: (NSObjectProtocol & QuestionsRoutingLogic)?
    
    private var viewModel = QuestionsViewModel.init(cells: [])
    private let oneHeaderCell = 1
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var emptyPlaceholder: UIView!
    private let refreshControl = UIRefreshControl()
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        
        setupTables()
    }

    private func setupTables() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        
        let questionNib = UINib(nibName: "QuestionCell", bundle: nil)
        tableView.register(questionNib, forCellReuseIdentifier: QuestionCell.reuseID)
        
        let searchNib = UINib(nibName: "SearchCell", bundle: nil)
        tableView.register(searchNib, forCellReuseIdentifier: SearchCell.reuseID)
    }
    
    @objc private func refreshData() {
        interactor?.makeRequest(request: .update)
    }
    
}

// MARK: - Questions Display Logic

extension QuestionsViewController: QuestionsDisplayLogic {
    
    func displayData(viewModel: Questions.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayQuestions(viewModel: let viewModel):
            self.viewModel = viewModel
            tableView.reloadData()
        case .showAlert(message: let message):
            showMessageAlert(with: message)
        }
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
    }
    
}

// MARK: - UI Table View Delegate & Data Source

extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cells.count + oneHeaderCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseID, for: indexPath) as? SearchCell
            else { return UITableViewCell() }
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.reuseID, for: indexPath) as? QuestionCell
            else { return UITableViewCell() }
            let viewModel = viewModel.cells[indexPath.row - oneHeaderCell]
            let isLast = (indexPath.row - 1 - oneHeaderCell) == self.viewModel.cells.count
            cell.setData(viewModel: viewModel, isLast: isLast)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let mask = TwoCornerRoundedMask(indexPath: indexPath,
                                        bounds: cell.bounds,
                                        cellIndexWithCorners: 1)
        cell.layer.mask = mask
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = viewModel.cells[indexPath.row - oneHeaderCell].questionID
        router?.navigateToAnswerPreview(id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Search Cell Delegate

extension QuestionsViewController: SearchCellDelegate {
    
    func searchQuery(with text: String) {
        emptyPlaceholder.isHidden = true
        viewModel.cells = []
        tableView.reloadData()
        activityIndicator.startAnimating()
        interactor?.makeRequest(request: .search(query: text))
    }
    
}
