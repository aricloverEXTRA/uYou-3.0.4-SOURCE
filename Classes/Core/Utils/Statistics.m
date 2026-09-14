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
    _lastDownloadDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setInteger:_totalDownloads forKey:@"uYouStat_total"];
}

- (void)recordDownloadCompletedWithBytes:(int64_t)bytes {
    _completedDownloads++;
    _totalBytesDownloaded += bytes;
    _lastDownloadDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setInteger:_completedDownloads forKey:@"uYouStat_completed"];
}

- (void)recordDownloadFailed {
    _failedDownloads++;
    [[NSUserDefaults standardUserDefaults] setInteger:_failedDownloads forKey:@"uYouStat_failed"];
}

- (void)updateAverageSpeed:(double)speed {
    _averageSpeed = speed;
    [[NSUserDefaults standardUserDefaults] setDouble:speed forKey:@"uYouStat_speed"];
}

+ (void)update:(id)arg1 {
    // Called from hooked Statistics update: — record generic event
    @try {
        [[self sharedStatistics] recordDownloadStarted];
    } @catch (id e) {}
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
