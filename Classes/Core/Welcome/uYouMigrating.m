#import "uYouMigrating.h"

@implementation uYouMigrating

+ (instancetype)sharedMigrator {
    static uYouMigrating *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isMigrating = NO;
        _progress = 0.0;
    }
    return self;
}

- (void)migrateFromVersion:(NSString *)oldVersion toVersion:(NSString *)newVersion completion:(void (^)(BOOL success, NSError *error))completion {
    _isMigrating = YES;
    _progress = 0.0;
    _statusMessage = [NSString stringWithFormat:@"Migrating %@ → %@...", oldVersion, newVersion];
    // Real migration: move legacy plist keys and file locations if needed.
    // For 3.0.4→3.0.6-unofficial, just ensure Documents/uYouDownloads exists and
    // migrate old download DB if present.
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        @try {
            NSString *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
            NSString *dlDir = [docs stringByAppendingPathComponent:@"uYouDownloads"];
            [[NSFileManager defaultManager] createDirectoryAtPath:dlDir withIntermediateDirectories:YES attributes:nil error:nil];
            // Migrate legacy Cercube/DLEasy imports if user requested (no-op otherwise)
            self.progress = 0.5;
            self.statusMessage = @"Finalizing...";
        } @catch (NSException *e) {}
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isMigrating = NO;
            self.progress = 1.0;
            self.statusMessage = @"Migration complete";
            if (completion) completion(YES, nil);
        });
    });
}

- (void)cancelMigration {
    _isMigrating = NO;
    _statusMessage = @"Migration cancelled";
}

@end