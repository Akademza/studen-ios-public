/*
 * Version for iOS © 2015–2021 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Ad delivery method.
 */
typedef NS_ENUM(NSUInteger, YMADeliveryMethod) {
    YMADeliveryMethodUnknown,
    YMADeliveryMethodStreaming,
    YMADeliveryMethodProgressive
};

/**
 * VAST MediaFile.
 */
@interface YMAVASTMediaFile : NSObject

/**
 * Optional media file identifier.
 */
@property (nonatomic, copy, readonly, nullable) NSString *ID;

/**
 * Location of linear file.
 */
@property (nonatomic, copy, readonly) NSString *URI;

/**
 * Ad delivery method.
 */
@property (nonatomic, assign, readonly) YMADeliveryMethod deliveryMethod;

/**
 * Video width.
 */
@property (nonatomic, assign, readonly) NSInteger width;

/**
 * Video height.
 */
@property (nonatomic, assign, readonly) NSInteger height;

/**
 * MIME type.
 */
@property (nonatomic, copy, readonly) NSString *MIMEType;

/**
 * Bitrate of encoded video in Kbps.
 */
@property (nonatomic, assign, readonly) NSInteger bitRate;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
