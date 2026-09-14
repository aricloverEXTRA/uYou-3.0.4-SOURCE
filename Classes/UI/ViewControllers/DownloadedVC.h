#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadedVC : UIViewController

@property (nonatomic, strong) UITableView *tableView;

- (instancetype)init;
- (void)updatePageStyles;

@end

NS_ASSUME_NONNULL_END