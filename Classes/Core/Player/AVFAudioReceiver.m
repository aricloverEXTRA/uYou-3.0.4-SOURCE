#import "AVFAudioReceiver.h"

@interface AVFAudioReceiver ()

@property (nonatomic, strong) AVAudioEngine *audioEngine;
@property (nonatomic, strong) AVAudioInputNode *inputNode;
@property (nonatomic, strong) AVAudioFormat *format;
@property (nonatomic, assign) BOOL isRunning;

@end

@implementation AVFAudioReceiver

- (instancetype)initWithFormat:(AVAudioFormat *)format {
    self = [super init];
    if (self) {
        _format = format;
        _audioEngine = [[AVAudioEngine alloc] init];
        _inputNode = _audioEngine.inputNode;
        _isRunning = NO;
    }
    return self;
}

- (void)start {
    if (_isRunning) return;
    
    NSError *error = nil;
    [_audioEngine prepare];
    [_audioEngine startAndReturnError:&error];
    
    if (error) {
        if ([_delegate respondsToSelector:@selector(audioReceiver:didFailWithError:)]) {
            [_delegate audioReceiver:self didFailWithError:error];
        }
        return;
    }
    
    _isRunning = YES;
    if ([_delegate respondsToSelector:@selector(audioReceiverDidStart:)]) {
        [_delegate audioReceiverDidStart:self];
    }
}

- (void)stop {
    if (!_isRunning) return;
    
    [_audioEngine stop];
    _isRunning = NO;
    if ([_delegate respondsToSelector:@selector(audioReceiverDidStop:)]) {
        [_delegate audioReceiverDidStop:self];
    }
}

- (void)setVolume:(float)volume {
    _inputNode.volume = volume;
}

@end