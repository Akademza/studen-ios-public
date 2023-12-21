/*
 * Version for iOS © 2015–2019 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Type of resource element.
 */
typedef NS_ENUM(NSUInteger, YMAVASTIconResourceType) {
    YMAVASTIconResourceTypeUnknown,
    YMAVASTIconResourceTypeStatic,
    YMAVASTIconResourceTypeIFrame,
    YMAVASTIconResourceTypeHTML
};

/**
 * Icon horizontal position. 
 * For YMAVASTIconHorizontalPositionLeft or YMAVASTIconHorizontalPositionRight
 * icon should be positioned to left or right accordingly.
 * YMAVASTIconHorizontalPositionLeftOffset means that position from x property should be used.
 */
typedef NS_ENUM(NSUInteger, YMAVASTIconHorizontalPosition) {
    YMAVASTIconHorizontalPositionLeft,
    YMAVASTIconHorizontalPositionRight,
    YMAVASTIconHorizontalPositionLeftOffset
};

/**
 * Icon vertical position. 
 * For YMAVASTIconVerticalPositionTop or YMAVASTIconVerticalPositionBottom
 * icon should be positioned to top or bottom accordingly.
 * YMAVASTIconVerticalPositionTopOffset means that position from y property should be used.
 */
typedef NS_ENUM(NSUInteger, YMAVASTIconVerticalPosition) {
    YMAVASTIconVerticalPositionTop,
    YMAVASTIconVerticalPositionBottom,
    YMAVASTIconVerticalPositionTopOffset
};

@interface YMAVASTIcon : NSObject

/**
 * Industry initiative that icon supports.
 */
@property (nonatomic, copy, readonly) NSString *program;

/**
 * Icon horizontal position.
 * For YMAVASTIconHorizontalPositionLeft or YMAVASTIconHorizontalPositionRight
 * icon should be positioned to left or right accordingly.
 * YMAVASTIconHorizontalPositionLeftOffset means that position from x property should be used.
 */
@property (nonatomic, assign, readonly) YMAVASTIconHorizontalPosition horizontalPosition;

/**
 * Icon vertical position.
 * For YMAVASTIconVerticalPositionTop or YMAVASTIconVerticalPositionBottom
 * icon should be positioned to top or bottom accordingly.
 * YMAVASTIconVerticalPositionTopOffset means that position from y property should be used.
 */
@property (nonatomic, assign, readonly) YMAVASTIconVerticalPosition verticalPosition;

/**
 * Horizontal position that the video player uses
 * to place the top-left corner of the icon relative to the ad display area
 * (not necessarily the video player display area).
 * Should only be used if horizontalPosition is YMAVASTIconHorizontalPositionLeftOffset.
 */
@property (nonatomic, assign, readonly) NSInteger x;

/**
 * Vertical position that the video player uses
 * to place the top-left corner of the icon relative to the ad display area 
 * (not necessarily the video player display area).
 * Should only be used if verticalPosition is YMAVASTIconVerticalPositionTopOffset.
 */
@property (nonatomic, assign, readonly) NSInteger y;

/**
 * The width (in pixels) of the icon to be overlaid on the Ad.
 */
@property (nonatomic, assign, readonly) NSInteger width;

/**
 * The height (in pixels) of the icon to be overlaid on the Ad.
 */
@property (nonatomic, assign, readonly) NSInteger height;

/**
 * Resource type.
 */
@property (nonatomic, assign, readonly) YMAVASTIconResourceType resourceType;

/**
 * URI to icon resource file.
 */
@property (nonatomic, copy, readonly, nullable) NSString *resourceURI;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
