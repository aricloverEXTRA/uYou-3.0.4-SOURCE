#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRPSection : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithTitle:(NSString *)title footer:(NSString *)footer items:(NSArray *)items;

@end

NS_ASSUME_NONNULL_END