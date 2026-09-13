#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AVFAudioReceiverDelegate <NSObject>
@optional
- (void)audioReceiver:(id)receiver didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (void)audioReceiverDidStart:(id)receiver;
- (void)audioReceiverDidStop:(id)receiver;
- (void)audioReceiver:(id)receiver didFailWithError:(NSError *)error;
@end

@interface AVFAudioReceiver : NSObject

@property (nonatomic, weak) id<AVFAudioReceiverDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL isRunning;

- (instancetype)initWithFormat:(AVAudioFormat *)format;
- (void)start;
- (void)stop;
- (void)setVolume:(float)volume;

@end

NS_ASSUME_NONNULL_END