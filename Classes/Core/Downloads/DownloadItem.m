#import "DownloadItem.h"

@implementation DownloadItem

- (instancetype)initWithVideoID:(NSString *)videoID title:(NSString *)title thumbnailURL:(NSString *)thumbnailURL formatID:(NSString *)formatID {
    self = [super init];
    if (self) {
        _videoID = [videoID copy];
        _title = [title copy];
        _thumbnailURL = [thumbnailURL copy];
        _formatID = [formatID copy];
        _progress = 0.0;
        _fileSize = 0;
        _downloadedSize = 0;
        _status = DownloadStatusPending;
        _startDate = [NSDate date];
    }
    return self;
}

- (void)updateProgress:(double)progress downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {
    _progress = progress;
    _downloadedSize = downloadedSize;
    _fileSize = totalSize;
    if (progress > 0 && progress < 1.0) {
        _status = DownloadStatusDownloading;
    }
}

- (void)setStatus:(DownloadStatus)status errorMessage:(NSString * _Nullable)errorMessage {
    _status = status;
    _errorMessage = [errorMessage copy];
    if (status == DownloadStatusCompleted || status == DownloadStatusFailed || status == DownloadStatusCancelled) {
        _completionDate = [NSDate date];
    }
}

- (void)cancel {
    _status = DownloadStatusCancelled;
    _completionDate = [NSDate date];
}

- (BOOL)isActive {
    return _status == DownloadStatusDownloading || _status == DownloadStatusConverting;
}

@end