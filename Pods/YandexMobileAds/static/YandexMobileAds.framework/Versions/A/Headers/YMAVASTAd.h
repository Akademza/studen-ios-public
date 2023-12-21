/*
 * Version for iOS © 2015–2021 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YMAVASTCreative;
@class YMAVASTExtension;

/**
 * VAST ad type.
 */
typedef NS_ENUM(NSUInteger, YMAVASTAdType) {
    YMAVASTAdTypeUnknown,
    YMAVASTAdTypeInLine,
    YMAVASTAdTypeWrapper
};

/**
 * VAST ad.
 */
@interface YMAVASTAd : NSObject

/**
 * VAST ad type.
 * @see YMAVASTAdType.
 */
@property (nonatomic, assign, readonly) YMAVASTAdType adType;

/**
 * Indicates source ad server.
 */
@property (nonatomic, copy, readonly, nullable) NSString *adSystem;

/**
 * Ad common name.
 */
@property (nonatomic, copy, readonly, nullable) NSString *adTitle;

/**
 * Ad description.
 */
@property (nonatomic, copy, readonly, nullable) NSString *adDescription;

/**
 * URI of request to survey vendor.
 */
@property (nonatomic, copy, readonly, nullable) NSString *survey;

/**
 * Array of YMAVASTCreative.
 */
@property (nonatomic, copy, readonly) NSArray<YMAVASTCreative *> *creatives;

/**
 * URI of ad tag of downstream Secondary Ad Server.
 */
@property (nonatomic, copy, readonly, nullable) NSString *VASTAdTagURI;

/**
 * Raw VAST XML
 */
@property (nonatomic, copy, readonly, nullable) NSString *rawVAST;

/*
 * Indicates order in the Ad Pod.
 */
@property (nonatomic, strong, readonly, nullable) NSNumber *sequence;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
