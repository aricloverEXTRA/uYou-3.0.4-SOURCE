#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RequestPriority) {
    RequestPriorityLow = 0,
    RequestPriorityNormal = 1,
    RequestPriorityHigh = 2
};

@interface RequestItem : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSDictionary *headers;
@property (nonatomic, copy) NSData *body;
@property (nonatomic, assign) RequestPriority priority;
@property (nonatomic, copy) void (^completionHandler)(NSData *data, NSURLResponse *response, NSError *error);

- (instancetype)initWithURL:(NSString *)url method:(NSString *)method headers:(NSDictionary *)headers body:(NSData *)body priority:(RequestPriority)priority completion:(void (^)(NSData *, NSURLResponse *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END