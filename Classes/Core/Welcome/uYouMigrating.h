#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface uYouMigrating : NSObject

@property (nonatomic, assign) BOOL isMigrating;
@property (nonatomic, assign) double progress;
@property (nonatomic, copy) NSString *statusMessage;

+ (instancetype)sharedMigrator;

- (void)migrateFromVersion:(NSString *)oldVersion toVersion:(NSString *)newVersion completion:(void (^)(BOOL success, NSError *error))completion;
- (void)cancelMigration;

@end

NS_ASSUME_NONNULL_END