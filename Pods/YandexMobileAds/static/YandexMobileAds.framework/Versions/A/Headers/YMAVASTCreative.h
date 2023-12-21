/*
 * Version for iOS © 2015–2021 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>

@class YMAVASTIcon;
@class YMAVASTMediaFile;
@class YMAVASTSkipOffset;

NS_ASSUME_NONNULL_BEGIN

/**
 * VAST Creative.
 */
@interface YMAVASTCreative : NSObject

/**
 * Optional creative identifier.
 */
@property (nonatomic, copy, readonly, nullable) NSString *ID;

/**
 * Duration in seconds.
 */
@property (nonatomic, assign, readonly) NSInteger duration;

/**
 * URI to open when user clicks on the video.
 */
@property (nonatomic, copy, readonly, nullable) NSString *clickThrough;

/**
 * Array of YMAMediaFile objects.
 */
@property (nonatomic, copy, readonly) NSArray<YMAVASTMediaFile *> *mediaFiles;

/**
 * Array of YMAVASTIcon objects.
 */
@property (nonatomic, copy, readonly) NSArray<YMAVASTIcon *> *icons;

/**
 * Skip offset for the ad creative.
 */
@property (nonatomic, strong, readonly, nullable) YMAVASTSkipOffset *skipOffset;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
