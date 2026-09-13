#import "FRPViewSection.h"

@implementation FRPViewSection

- (instancetype)initWithTitle:(NSString *)title view:(UIView *)view {
    self = [super init];
    if (self) {
        _title = [title copy];
        _view = view;
    }
    return self;
}

@end