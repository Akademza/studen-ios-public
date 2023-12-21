/*
 * Version for iOS © 2015–2020 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>

/**
 YMAVASTSkipOffset represents skip offset for the ad.
 */
@interface YMAVASTSkipOffset : NSObject

/**
 Raw value of skipOffset attribute that represents the skip offset for the ad.
 */
@property (nonatomic, copy, readonly) NSString *rawValue;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end
