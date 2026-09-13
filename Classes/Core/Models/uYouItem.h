#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface uYouItem : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, strong) NSDictionary *metadata;

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title subtitle:(NSString *)subtitle imageURL:(NSString *)imageURL metadata:(NSDictionary *)metadata;

@end

NS_ASSUME_NONNULL_END