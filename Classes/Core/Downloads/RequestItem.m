#import "RequestItem.h"

@implementation RequestItem

- (instancetype)initWithURL:(NSString *)url method:(NSString *)method headers:(NSDictionary *)headers body:(NSData *)body priority:(RequestPriority)priority completion:(void (^)(NSData *, NSURLResponse *, NSError *))completion {
    self = [super init];
    if (self) {
        _url = [url copy];
        _method = [method copy];
        _headers = [headers copy];
        _body = [body copy];
        _priority = priority;
        _completionHandler = [completion copy];
    }
    return self;
}

@end