//
//  QuestionPreviewViewController.swift
//  studen-ios
//
//  Created by Andreas on 15.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QuestionPreviewDisplayLogic: AnyObject {
    func displayData(viewModel: QuestionPreview.Model.ViewModel.ViewModelData)
}

class QuestionPreviewViewController: UIViewController, QuestionPreviewDisplayLogic {
    
    var interactor: QuestionPreviewBusinessLogic?
    var router: (NSObjectProtocol & QuestionPreviewRoutingLogic)?
    var questionID: Int?
    
    private var viewModel = QuestionPreviewViewModel.init(questionModel: nil, answers: [])
    private let oneQuestionCell = 1
    
    @IBOutlet private weak var tableView: TransparentTableView!
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTables()
        interactor?.makeRequest(request: .fetchModel(id: questionID))
    }
    
    private func setupTables() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        
        let questionNib = UINib(nibName: "AnswerCell", bundle: nil)
        tableView.register(questionNib, forCellReuseIdentifier: AnswerCell.reuseID)
        
        let searchNib = UINib(nibName: "HeaderCell", bundle: nil)
        tableView.register(searchNib, forCellReuseIdentifier: HeaderCell.reuseID)
        
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func displayData(viewModel: QuestionPreview.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayQuestionModel(viewModel: let viewModel):
            self.viewModel = viewModel
            tableView.reloadData()
        case .showAlert(error: let error):
            showMessageAlert(with: error)
        }
    }
    
    @IBAction private func dismissScene() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UI Table View Delegate & Data Source

extension QuestionPreviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.answers.count + oneQuestionCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.reuseID, for: indexPath) as? HeaderCell
            else { return UITableViewCell() }
            let viewModel = viewModel.questionModel
            cell.setData(viewModel)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.reuseID, for: indexPath) as? AnswerCell
            else { return UITableViewCell() }
            let viewModel = viewModel.answers[indexPath.row - oneQuestionCell]
            cell.setData(viewModel)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let mask = TwoCornerRoundedMask(indexPath: indexPath,
                                        bounds: cell.bounds,
                                        cellIndexWithCorners: 0)
        cell.layer.mask = mask
    }
}

// MARK: - Answer Cell Delegate

extension QuestionPreviewViewController: AnswerCellDelegate {
    
    func navigateToPayment() {
        router?.navigateToPayment()
    }
    
}
