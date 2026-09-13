#import "MetadataItem.h"

@implementation MetadataItem

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value language:(NSString *)language isDefault:(BOOL)isDefault {
    self = [super init];
    if (self) {
        _key = [key copy];
        _value = [value copy];
        _language = [language copy];
        _isDefault = isDefault;
    }
    return self;
}

@end