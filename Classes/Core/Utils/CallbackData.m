#import "CallbackData.h"

@implementation CallbackData

- (instancetype)initWithCallbackID:(NSString *)callbackID data:(id)data completion:(void (^)(id, NSError *))completion {
    self = [super init];
    if (self) {
        _callbackID = [callbackID copy];
        _data = data;
        _completion = [completion copy];
    }
    return self;
}

@end