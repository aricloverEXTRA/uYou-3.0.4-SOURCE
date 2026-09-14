#import "uYouCheckUpdate.h"

@implementation uYouCheckUpdate

+ (instancetype)sharedChecker {
    static uYouCheckUpdate *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentVersion = @"3.0.6-unofficial";
        _hasUpdate = NO;
    }
    return self;
}

- (void)checkForUpdatesWithCompletion:(void (^)(BOOL hasUpdate, NSError *error))completion {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"automaticallyCheckForUpdates"]) {
        if (completion) completion(NO, nil);
        return;
    }
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/repos/arichornlover/uYouEnhanced/releases/latest"];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *d, NSURLResponse *r, NSError *e) {
        if (e || !d) { if (completion) dispatch_async(dispatch_get_main_queue(), ^{ completion(NO, e); }); return; }
        NSDictionary *j = [NSJSONSerialization JSONObjectWithData:d options:0 error:nil];
        NSString *tag = j[@"tag_name"];
        if (tag.length) {
            NSString *latest = [tag stringByReplacingOccurrencesOfString:@"v" withString:@""];
            BOOL has = [latest compare:_currentVersion options:NSNumericSearch] == NSOrderedDescending;
            _latestVersion = latest;
            _hasUpdate = has;
            _releaseNotes = j[@"body"];
            _downloadURL = j[@"html_url"];
            if (completion) dispatch_async(dispatch_get_main_queue(), ^{ completion(has, nil); });
        } else {
            if (completion) dispatch_async(dispatch_get_main_queue(), ^{ completion(NO, nil); });
        }
    }] resume];
}

- (void)downloadUpdateWithProgress:(void (^)(double progress))progressBlock completion:(void (^)(BOOL success, NSError *error))completionBlock {
    if (!_downloadURL.length) {
        if (completionBlock) completionBlock(NO, [NSError errorWithDomain:@"uYouCheckUpdate" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"No download URL"}]);
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_downloadURL] options:@{} completionHandler:nil];
    if (completionBlock) completionBlock(YES, nil);
}

@end