#import "FRPSettings.h"

@implementation FRPSettings

- (instancetype)initWithTitle:(NSString *)title sections:(NSArray<FRPSection *> *)sections {
    self = [super init];
    if (self) {
        _title = [title copy];
        _sections = [sections copy];
    }
    return self;
}

@end