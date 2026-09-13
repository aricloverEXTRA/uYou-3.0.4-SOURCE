#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRPreferences : NSObject

@property (nonatomic, strong) NSUserDefaults *userDefaults;

+ (instancetype)sharedPreferences;

- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (void)setInteger:(NSInteger)value forKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (void)setFloat:(float)value forKey:(NSString *)key;
- (float)floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (void)setString:(NSString *)value forKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (void)setObject:(id)value forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key defaultValue:(id)defaultValue;
- (void)removeObjectForKey:(NSString *)key;
- (void)synchronize;

@end

NS_ASSUME_NONNULL_END