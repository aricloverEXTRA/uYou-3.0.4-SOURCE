#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AVFFrameReceiverDelegate <NSObject>
@optional
- (void)frameReceiver:(id)receiver didOutputPixelBuffer:(CVPixelBufferRef)pixelBuffer atTime:(CMTime)time;
- (void)frameReceiverDidStart:(id)receiver;
- (void)frameReceiverDidStop:(id)receiver;
- (void)frameReceiver:(id)receiver didFailWithError:(NSError *)error;
@end

@interface AVFFrameReceiver : NSObject

@property (nonatomic, weak) id<AVFFrameReceiverDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isRunning;

- (instancetype)initWithFormat:(CMVideoFormatDescriptionRef)format;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END