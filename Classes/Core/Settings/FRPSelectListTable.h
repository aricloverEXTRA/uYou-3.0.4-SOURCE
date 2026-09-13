#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FRPSelectListTableDelegate <NSObject>
@optional
- (void)selectListTable:(id)table didSelectItemAtIndex:(NSInteger)index;
@end

@interface FRPSelectListTable : UITableView

@property (nonatomic, weak) id<FRPSelectListTableDelegate> selectDelegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger selectedIndex;

- (instancetype)initWithItems:(NSArray *)items selectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END