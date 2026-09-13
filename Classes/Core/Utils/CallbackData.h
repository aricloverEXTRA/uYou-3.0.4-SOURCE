#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CallbackData : NSObject

@property (nonatomic, copy) NSString *callbackID;
@property (nonatomic, strong) id data;
@property (nonatomic, copy) void (^completion)(id result, NSError *error);

- (instancetype)initWithCallbackID:(NSString *)callbackID data:(id)data completion:(void (^)(id, NSError *))completion;

@end

NS_ASSUME_NONNULL_END