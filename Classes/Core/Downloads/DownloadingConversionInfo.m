#import "DownloadingConversionInfo.h"

@implementation DownloadingConversionInfo

- (instancetype)initWithVideoID:(NSString *)videoID formatID:(NSString *)formatID filePath:(NSString *)filePath {
    self = [super init];
    if (self) {
        _videoID = [videoID copy];
        _formatID = [formatID copy];
        _filePath = [filePath copy];
        _progress = 0.0;
        _isCancelled = NO;
        _isCompleted = NO;
    }
    return self;
}

- (void)updateProgress:(double)progress {
    _progress = progress;
}

- (void)cancel {
    _isCancelled = YES;
}

- (void)complete {
    _isCompleted = YES;
    _progress = 1.0;
}

@end