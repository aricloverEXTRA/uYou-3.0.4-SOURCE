#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GLViewPagerViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, assign) NSInteger currentPage;

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers;

@end

NS_ASSUME_NONNULL_END