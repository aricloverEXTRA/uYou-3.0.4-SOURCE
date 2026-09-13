#import "FRPSection.h"

@implementation FRPSection

- (instancetype)initWithTitle:(NSString *)title footer:(NSString *)footer items:(NSArray *)items {
    self = [super init];
    if (self) {
        _title = [title copy];
        _footer = [footer copy];
        _items = [items copy];
    }
    return self;
}

@end