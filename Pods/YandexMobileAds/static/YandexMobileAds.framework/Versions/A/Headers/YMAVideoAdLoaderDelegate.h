/*
 * Version for iOS © 2015–2019 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>

@class YMAVASTAd;

NS_ASSUME_NONNULL_BEGIN
/**
 Delegates which adopt YMAVideoAdLoaderDelegate are notified on VAST block loading state changes.
 */
@protocol YMAVideoAdLoaderDelegate <NSObject>

/**
 Called when VAST Ads have been successfully loaded.
 @param ads NSArray of YMAVASTAd objects describing each individual VAST block. Usually there is only one object.
 */
- (void)loaderDidLoadVideoAds:(NSArray<YMAVASTAd *> *)ads;

/**
 Called when error occured while loading VAST Ads.
 @param error NSError object describing problem encountered while loading VAST Ads. UserInfo dictionary may contain
 additional information, such as server response, that cannot be parsed as an XML. @see YMAVASTSpecialResponseTextKey.
 */
- (void)loaderDidFailLoadingVideoAdsWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
