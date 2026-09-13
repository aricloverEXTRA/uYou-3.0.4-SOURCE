#import "uYouItem.h"

@implementation uYouItem

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title subtitle:(NSString *)subtitle imageURL:(NSString *)imageURL metadata:(NSDictionary *)metadata {
    self = [super init];
    if (self) {
        _identifier = [identifier copy];
        _title = [title copy];
        _subtitle = [subtitle copy];
        _imageURL = [imageURL copy];
        _metadata = [metadata copy];
    }
    return self;
}

@end