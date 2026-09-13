#import "AVFFrameReceiver.h"

@interface AVFFrameReceiver ()

@property (nonatomic, strong) AVAssetReader *assetReader;
@property (nonatomic, strong) AVAssetReaderTrackOutput *trackOutput;
@property (nonatomic, assign) BOOL isRunning;

@end

@implementation AVFFrameReceiver

- (instancetype)initWithFormat:(CMVideoFormatDescriptionRef)format {
    self = [super init];
    if (self) {
        _isRunning = NO;
    }
    return self;
}

- (void)start {
    if (_isRunning) return;
    _isRunning = YES;
    if ([_delegate respondsToSelector:@selector(frameReceiverDidStart:)]) {
        [_delegate frameReceiverDidStart:self];
    }
}

- (void)stop {
    if (!_isRunning) return;
    _isRunning = NO;
    if ([_delegate respondsToSelector:@selector(frameReceiverDidStop:)]) {
        [_delegate frameReceiverDidStop:self];
    }
}

@end