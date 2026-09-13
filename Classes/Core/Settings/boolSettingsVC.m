#import "boolSettingsVC.h"

@implementation boolSettingsVC

- (instancetype)initWithKey:(NSString *)key title:(NSString *)title itemDescription:(NSString *)itemDescription defaultValue:(BOOL)defaultValue {
    self = [super init];
    if (self) {
        _key = [key copy];
        _title = [title copy];
        _itemDescription = [itemDescription copy];
        _defaultValue = defaultValue;
        _currentValue = defaultValue;
    }
    return self;
}

@end