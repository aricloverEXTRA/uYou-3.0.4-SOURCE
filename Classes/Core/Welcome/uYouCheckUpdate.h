#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface uYouCheckUpdate : NSObject

@property (nonatomic, copy) NSString *currentVersion;
@property (nonatomic, copy) NSString *latestVersion;
@property (nonatomic, copy) NSString *releaseNotes;
@property (nonatomic, copy) NSString *downloadURL;
@property (nonatomic, assign) BOOL hasUpdate;

+ (instancetype)sharedChecker;

- (void)checkForUpdatesWithCompletion:(void (^)(BOOL hasUpdate, NSError *error))completion;
- (void)downloadUpdateWithProgress:(void (^)(double progress))progressBlock completion:(void (^)(BOOL success, NSError *error))completionBlock;

@end

NS_ASSUME_NONNULL_END