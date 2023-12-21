/*
 * Version for iOS © 2015–2021 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 This class is responsible for configuring native ad loading.
 */
@interface YMANativeAdRequestConfiguration : NSObject <NSCopying, NSMutableCopying>

/**
 The Block ID is a unique identifier in the R-M-XXXXXX-Y format, which is assigned in the Partner interface.
 */
@property (nonatomic, copy, readonly) NSString *blockID;

/**
 User age.
 */
@property (nonatomic, strong, readonly, nullable) NSNumber *age;

/**
 The search query that the user entered in the app.
 */
@property (nonatomic, copy, readonly, nullable) NSString *contextQuery;

/**
 List of tags. Matches the context in which the ad will be displayed.
 */
@property (nonatomic, copy, readonly, nullable) NSArray<NSString *> *contextTags;

/**
 The gender of the user. For a list of values, see the YMAGender section.
 */
@property (nonatomic, copy, readonly, nullable) NSString *gender;

/**
 User location.
 */
@property (nonatomic, copy, readonly, nullable) CLLocation *location;

/**
 A set of arbitrary input parameters.
 */
@property (nonatomic, copy, readonly, nullable) NSDictionary<NSString *, NSString*> *parameters;

/**
 Flag for automatic image loading. Acceptable values: `YES` – Load automatically; `NO` – Load manually.
 @warning If the app simultaneously stores links to a large number of ads,
 we recommend using manual image loading.
 */
@property (nonatomic, assign, readonly) BOOL shouldLoadImagesAutomatically;

- (instancetype)init __attribute__((unavailable("Use initWithBlockID: instead")));

+ (instancetype)new __attribute__((unavailable("Use initWithBlockID: instead")));
/**
 Initializes a new object of the YMANativeAdRequestConfiguration class.
 @param blockID The Block ID is a unique identifier in the R-M-XXXXXX-Y format,
 which is assigned in the Partner interface.
 @return An object of the YMANativeAdRequestConfiguration class, configuration for loading native ads.
 */
- (instancetype)initWithBlockID:(NSString *)blockID;

@end

NS_ASSUME_NONNULL_END
