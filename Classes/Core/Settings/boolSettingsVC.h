#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface boolSettingsVC : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *itemDescription;
@property (nonatomic, assign) BOOL defaultValue;
@property (nonatomic, assign) BOOL currentValue;

- (instancetype)initWithKey:(NSString *)key title:(NSString *)title itemDescription:(NSString *)itemDescription defaultValue:(BOOL)defaultValue;

@end

NS_ASSUME_NONNULL_END