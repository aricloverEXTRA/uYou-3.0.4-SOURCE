#import "DownloadsManager.h"
#import "DownloadItem.h"

@interface DownloadsManager ()

@property (nonatomic, strong) NSMutableArray<DownloadItem *> *downloads;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation DownloadsManager

+ (instancetype)sharedManager {
    static DownloadsManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _downloads = [NSMutableArray array];
        _queue = dispatch_queue_create("com.uyou.downloads.manager", DISPATCH_QUEUE_SERIAL);
        [self loadDownloads];
    }
    return self;
}

- (NSArray<DownloadItem *> *)downloads {
    return [_downloads copy];
}

- (NSArray<DownloadItem *> *)activeDownloads {
    return [_downloads filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DownloadItem *item, NSDictionary *bindings) {
        return item.status == DownloadStatusDownloading || item.status == DownloadStatusConverting;
    }]];
}

- (NSArray<DownloadItem *> *)completedDownloads {
    return [_downloads filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DownloadItem *item, NSDictionary *bindings) {
        return item.status == DownloadStatusCompleted;
    }]];
}

- (void)addDownloadWithVideoID:(NSString *)videoID title:(NSString *)title thumbnailURL:(NSString *)thumbnailURL formatID:(NSString *)formatID {
    dispatch_async(_queue, ^{
        DownloadItem *existing = [self downloadForVideoID:videoID];
        if (existing) {
            return;
        }
        
        DownloadItem *download = [[DownloadItem alloc] initWithVideoID:videoID title:title thumbnailURL:thumbnailURL formatID:formatID];
        [_downloads addObject:download];
        [self saveDownloads];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(downloadsManager:didAddDownload:)]) {
                [_delegate downloadsManager:self didAddDownload:download];
            }
        });
    });
}

- (void)removeDownload:(DownloadItem *)download {
    dispatch_async(_queue, ^{
        [_downloads removeObject:download];
        [self saveDownloads];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(downloadsManager:didRemoveDownload:)]) {
                [_delegate downloadsManager:self didRemoveDownload:download];
            }
        });
    });
}

- (void)cancelDownload:(DownloadItem *)download {
    [download cancel];
    [self saveDownloads];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_delegate respondsToSelector:@selector(downloadsManager:didChangeStatus:)]) {
            [_delegate downloadsManager:self didChangeStatus:download];
        }
    });
}

- (void)cancelAllDownloads {
    dispatch_async(_queue, ^{
        for (DownloadItem *download in _downloads) {
            if ([download isActive]) {
                [download cancel];
            }
        }
        [self saveDownloads];
    });
}

- (void)clearCompletedDownloads {
    dispatch_async(_queue, ^{
        [_downloads removeObjectsAtIndexes:[_downloads indexesOfObjectsPassingTest:^BOOL(DownloadItem *item, NSUInteger idx, BOOL *stop) {
            return item.status == DownloadStatusCompleted;
        }]];
        [self saveDownloads];
    });
}

- (void)retryFailedDownload:(DownloadItem *)download {
    if (download.status == DownloadStatusFailed) {
        download.status = DownloadStatusPending;
        download.progress = 0.0;
        download.downloadedSize = 0;
        download.errorMessage = (NSString *)nil;
        [self saveDownloads];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(downloadsManager:didChangeStatus:)]) {
                [_delegate downloadsManager:self didChangeStatus:download];
            }
        });
    }
}

- (DownloadItem *)downloadForVideoID:(NSString *)videoID {
    __block DownloadItem *found = nil;
    dispatch_sync(_queue, ^{
        for (DownloadItem *item in _downloads) {
            if ([item.videoID isEqualToString:videoID]) {
                found = item;
                break;
            }
        }
    });
    return found;
}

- (void)saveDownloads {
    dispatch_async(_queue, ^{
        NSMutableArray *array = [NSMutableArray array];
        for (DownloadItem *download in _downloads) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"videoID"] = download.videoID ?: @"";
            dict[@"title"] = download.title ?: @"";
            dict[@"thumbnailURL"] = download.thumbnailURL ?: @"";
            dict[@"formatID"] = download.formatID ?: @"";
            if (download.filePath) dict[@"filePath"] = download.filePath;
            dict[@"progress"] = @(download.progress);
            dict[@"fileSize"] = @(download.fileSize);
            dict[@"downloadedSize"] = @(download.downloadedSize);
            dict[@"status"] = @(download.status);
            if (download.errorMessage) dict[@"errorMessage"] = download.errorMessage;
            if (download.startDate) dict[@"startDate"] = download.startDate;
            if (download.completionDate) dict[@"completionDate"] = download.completionDate;
            [array addObject:dict];
        }
        
        NSString *path = [self downloadsPlistPath];
        [array writeToFile:path atomically:YES];
    });
}

- (void)loadDownloads {
    dispatch_async(_queue, ^{
        NSString *path = [self downloadsPlistPath];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        if (!array) return;
        
        [_downloads removeAllObjects];
        for (NSDictionary *dict in array) {
            DownloadItem *download = [[DownloadItem alloc] initWithVideoID:dict[@"videoID"] title:dict[@"title"] thumbnailURL:dict[@"thumbnailURL"] formatID:dict[@"formatID"]];
            download.filePath = dict[@"filePath"];
            download.progress = [dict[@"progress"] doubleValue];
            download.fileSize = [dict[@"fileSize"] longLongValue];
            download.downloadedSize = [dict[@"downloadedSize"] longLongValue];
            download.status = [dict[@"status"] integerValue];
            download.errorMessage = dict[@"errorMessage"];
            download.startDate = dict[@"startDate"];
            download.completionDate = dict[@"completionDate"];
            [_downloads addObject:download];
        }
    });
}

- (NSString *)downloadsPlistPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths firstObject] stringByAppendingPathComponent:@"uyou_downloads.plist"];
}

@end