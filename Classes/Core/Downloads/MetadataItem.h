#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MetadataItem : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, assign) BOOL isDefault;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value language:(NSString *)language isDefault:(BOOL)isDefault;

@end

NS_ASSUME_NONNULL_END