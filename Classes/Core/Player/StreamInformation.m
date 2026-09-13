#import "StreamInformation.h"

@implementation StreamInformation

- (instancetype)initWithURL:(NSString *)url formatID:(NSString *)formatID mimeType:(NSString *)mimeType codec:(NSString *)codec bitrate:(int64_t)bitrate resolution:(CGSize)resolution duration:(NSTimeInterval)duration isLive:(BOOL)isLive segments:(NSArray *)segments {
    self = [super init];
    if (self) {
        _url = [url copy];
        _formatID = [formatID copy];
        _mimeType = [mimeType copy];
        _codec = [codec copy];
        _bitrate = bitrate;
        _resolution = resolution;
        _duration = duration;
        _isLive = isLive;
        _segments = [segments copy];
    }
    return self;
}

@end