#import <UIKit/UIKit.h>

@class DownloadingVC;
@class DownloadedVC;

NS_ASSUME_NONNULL_BEGIN

@interface DownloadsPagerVC : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DownloadingVC *downloadingVC;
@property (nonatomic, strong) DownloadedVC *downloadedVC;

- (instancetype)init;
- (NSArray<UIViewController *> *)viewControllers;
- (void)updatePageStyles;
- (void)viewPager:(id)viewPager didChangeTabToIndex:(NSUInteger)idx fromTabIndex:(NSUInteger)fromIdx;

@end
void UYouRefreshAppearance(void);

NS_ASSUME_NONNULL_END