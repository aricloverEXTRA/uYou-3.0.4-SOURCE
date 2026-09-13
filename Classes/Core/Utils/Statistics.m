#import "Statistics.h"

@implementation Statistics

+ (instancetype)sharedStatistics {
    static Statistics *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _totalDownloads = 0;
        _completedDownloads = 0;
        _failedDownloads = 0;
        _totalBytesDownloaded = 0;
        _averageSpeed = 0.0;
    }
    return self;
}

- (void)recordDownloadStarted {
    _totalDownloads++;
}

- (void)recordDownloadCompletedWithBytes:(int64_t)bytes {
    _completedDownloads++;
    _totalBytesDownloaded += bytes;
}

- (void)recordDownloadFailed {
    _failedDownloads++;
}

- (void)updateAverageSpeed:(double)speed {
    _averageSpeed = speed;
}

- (NSDictionary *)statisticsDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"totalDownloads"] = @(_totalDownloads);
    dict[@"completedDownloads"] = @(_completedDownloads);
    dict[@"failedDownloads"] = @(_failedDownloads);
    dict[@"totalBytesDownloaded"] = @(_totalBytesDownloaded);
    dict[@"averageSpeed"] = @(_averageSpeed);
    if (_lastDownloadDate) dict[@"lastDownloadDate"] = _lastDownloadDate;
    return dict;
}

@end
