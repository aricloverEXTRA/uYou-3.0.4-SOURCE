#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DownloadStatus) {
    DownloadStatusPending = 0,
    DownloadStatusDownloading = 1,
    DownloadStatusConverting = 2,
    DownloadStatusCompleted = 3,
    DownloadStatusFailed = 4,
    DownloadStatusCancelled = 5
};

@interface DownloadItem : NSObject

@property (nonatomic, copy) NSString *videoID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, copy) NSString *formatID;
@property (nonatomic, copy, nullable) NSString *filePath;
@property (nonatomic, assign) double progress;
@property (nonatomic, assign) int64_t fileSize;
@property (nonatomic, assign) int64_t downloadedSize;
@property (nonatomic, assign) DownloadStatus status;
@property (nonatomic, copy, nullable) NSString *errorMessage;
@property (nonatomic, strong, nullable) NSDate *startDate;
@property (nonatomic, strong, nullable) NSDate *completionDate;

- (instancetype)initWithVideoID:(NSString *)videoID title:(NSString *)title thumbnailURL:(NSString *)thumbnailURL formatID:(NSString *)formatID;
- (void)updateProgress:(double)progress downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize;
- (void)setStatus:(DownloadStatus)status errorMessage:(NSString * _Nullable)errorMessage;
- (void)cancel;
- (BOOL)isActive;

@end

NS_ASSUME_NONNULL_END