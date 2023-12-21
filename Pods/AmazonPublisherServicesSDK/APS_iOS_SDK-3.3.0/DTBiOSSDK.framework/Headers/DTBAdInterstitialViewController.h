//
//  DTBAdInterstitialViewController.h
//  Serverless
//
//  Created by Krivopaltsev, Eugene on 12/19/18.
//  Copyright © 2018 Krivopaltsev, Eugene. All rights reserved.
//

@import UIKit;
@import WebKit;



NS_ASSUME_NONNULL_BEGIN

@class DTBAdView;
@protocol DTBAdInterstitialDispatcherDelegate;

@interface DTBAdInterstitialViewController : UIViewController

@property(nonatomic, weak) DTBAdView *adView;

@property(nonatomic) id<DTBAdInterstitialDispatcherDelegate> dispatcherDelegate;

@end

NS_ASSUME_NONNULL_END
