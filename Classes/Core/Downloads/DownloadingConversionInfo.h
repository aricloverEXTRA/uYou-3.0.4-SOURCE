#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadingConversionInfo : NSObject

@property (nonatomic, copy) NSString *videoID;
@property (nonatomic, copy) NSString *formatID;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, assign) double progress;
@property (nonatomic, assign) BOOL isCancelled;
@property (nonatomic, assign) BOOL isCompleted;

- (instancetype)initWithVideoID:(NSString *)videoID formatID:(NSString *)formatID filePath:(NSString *)filePath;
- (void)updateProgress:(double)progress;
- (void)cancel;
- (void)complete;

@end

NS_ASSUME_NONNULL_END