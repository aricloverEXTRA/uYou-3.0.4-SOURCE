#import "FRPreferences.h"

@implementation FRPreferences

+ (instancetype)sharedPreferences {
    static FRPreferences *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)setBool:(BOOL)value forKey:(NSString *)key {
    [_userDefaults setBool:value forKey:key];
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    if ([_userDefaults objectForKey:key] == nil) {
        return defaultValue;
    }
    return [_userDefaults boolForKey:key];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)key {
    [_userDefaults setInteger:value forKey:key];
}

- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue {
    if ([_userDefaults objectForKey:key] == nil) {
        return defaultValue;
    }
    return [_userDefaults integerForKey:key];
}

- (void)setFloat:(float)value forKey:(NSString *)key {
    [_userDefaults setFloat:value forKey:key];
}

- (float)floatForKey:(NSString *)key defaultValue:(float)defaultValue {
    if ([_userDefaults objectForKey:key] == nil) {
        return defaultValue;
    }
    return [_userDefaults floatForKey:key];
}

- (void)setString:(NSString *)value forKey:(NSString *)key {
    [_userDefaults setObject:value forKey:key];
}

- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    NSString *value = [_userDefaults stringForKey:key];
    return value ?: defaultValue;
}

- (void)setObject:(id)value forKey:(NSString *)key {
    [_userDefaults setObject:value forKey:key];
}

- (id)objectForKey:(NSString *)key defaultValue:(id)defaultValue {
    id value = [_userDefaults objectForKey:key];
    return value ?: defaultValue;
}

- (void)removeObjectForKey:(NSString *)key {
    [_userDefaults removeObjectForKey:key];
}

- (void)synchronize {
    [_userDefaults synchronize];
}

@end