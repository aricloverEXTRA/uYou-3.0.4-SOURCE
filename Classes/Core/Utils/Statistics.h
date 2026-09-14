#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Statistics : NSObject

@property (nonatomic, assign) int64_t totalDownloads;
@property (nonatomic, assign) int64_t completedDownloads;
@property (nonatomic, assign) int64_t failedDownloads;
@property (nonatomic, assign) int64_t totalBytesDownloaded;
@property (nonatomic, assign) double averageSpeed;
@property (nonatomic, strong, nullable) NSDate *lastDownloadDate;

+ (instancetype)sharedStatistics;
+ (void)update:(id)arg1;

- (void)recordDownloadStarted;
- (void)recordDownloadCompletedWithBytes:(int64_t)bytes;
- (void)recordDownloadFailed;
- (void)updateAverageSpeed:(double)speed;
- (NSDictionary *)statisticsDictionary;

@end

NS_ASSUME_NONNULL_END