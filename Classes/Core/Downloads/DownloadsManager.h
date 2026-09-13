#import <Foundation/Foundation.h>
#import "DownloadItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DownloadsManagerDelegate <NSObject>
@optional
- (void)downloadsManager:(id)manager didAddDownload:(DownloadItem *)download;
- (void)downloadsManager:(id)manager didUpdateDownload:(DownloadItem *)download;
- (void)downloadsManager:(id)manager didRemoveDownload:(DownloadItem *)download;
- (void)downloadsManager:(id)manager didChangeStatus:(DownloadItem *)download;
@end

@interface DownloadsManager : NSObject

@property (nonatomic, weak) id<DownloadsManagerDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray<DownloadItem *> *downloads;
@property (nonatomic, strong, readonly) NSArray<DownloadItem *> *activeDownloads;
@property (nonatomic, strong, readonly) NSArray<DownloadItem *> *completedDownloads;

+ (instancetype)sharedManager;

- (void)addDownloadWithVideoID:(NSString *)videoID title:(NSString *)title thumbnailURL:(NSString *)thumbnailURL formatID:(NSString *)formatID;
- (void)removeDownload:(DownloadItem *)download;
- (void)cancelDownload:(DownloadItem *)download;
- (void)cancelAllDownloads;
- (void)clearCompletedDownloads;
- (void)retryFailedDownload:(DownloadItem *)download;
- (DownloadItem *)downloadForVideoID:(NSString *)videoID;
- (void)saveDownloads;
- (void)loadDownloads;

@end

NS_ASSUME_NONNULL_END