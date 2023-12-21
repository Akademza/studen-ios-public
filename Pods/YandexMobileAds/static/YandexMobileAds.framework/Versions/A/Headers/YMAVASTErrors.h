/*
 * Version for iOS © 2015–2021 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>

/**
 Yandex Mobile Video Ads error domain.
 */
extern NSString *const kYMAVASTErrorDomain;

/**
 If the response can not be parsed as XML, loader returns error.
 kYMAVASTSpecialResponseTextKey is a key in userInfo
 for original server response.
 */
extern NSString *const kYMAVASTSpecialResponseTextKey;

/**
 Yandex Mobile Video Ads error code.
 */
typedef NS_ENUM(NSInteger, YMAVASTErrorCode) {
    /**
     Returned for empty VAST response.
     */
    YMAVASTErrorCodeNoAdsInVASTResponse,
    /**
     Returned for invalid XML in VAST response.
     */
    YMAVASTErrorCodeInvalidXMLResponse,
    /**
     Returned for invalid VAST request.
     */
    YMAVASTErrorCodeCannotBuildRequest
};
