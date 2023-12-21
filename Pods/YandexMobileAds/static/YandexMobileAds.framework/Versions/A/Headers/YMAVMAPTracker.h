/*
 * Version for iOS © 2015–2020 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://yandex.com/legal/mobileads_sdk_agreement/
 */

#import <Foundation/Foundation.h>

@class YMAVMAPAdBreak;

NS_ASSUME_NONNULL_BEGIN

/**
 * Constants below describe possible VMAP ad break events and errors.
 * They should be used as eventName parameter in
 * trackAdBreakEvent:eventName: method to track VMAP ad break events.
 */

/**
 * Ad break start event name
 */
extern NSString *const kYMAVMAPAdBreakStart;

/**
 * Ad break end event name
 */
extern NSString *const kYMAVMAPAdBreakEnd;

/**
 * Ad break error event name
 */
extern NSString *const kYMAVMAPAdBreakError;

/**
 * YMAVMAPTracker tracks VMAP events by sending them to server.
 */
@interface YMAVMAPTracker : NSObject

/**
 * Track ad break event.
 * @param adBreak YMAVMAPAdBreak object, that caused an event
 * @param eventName String event name. Possible values are described above
 */
- (void)trackAdBreakEvent:(YMAVMAPAdBreak *)adBreak eventName:(NSString *)eventName;

@end

NS_ASSUME_NONNULL_END
