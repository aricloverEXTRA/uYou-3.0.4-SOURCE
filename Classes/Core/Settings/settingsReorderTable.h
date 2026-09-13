#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface settingsReorderTable : UITableView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) void (^reorderHandler)(NSInteger fromIndex, NSInteger toIndex);

- (instancetype)initWithItems:(NSArray *)items reorderHandler:(void (^)(NSInteger, NSInteger))handler;

@end

NS_ASSUME_NONNULL_END