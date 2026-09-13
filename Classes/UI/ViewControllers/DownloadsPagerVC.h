#import <UIKit/UIKit.h>

@class DownloadingVC;
@class DownloadedVC;

NS_ASSUME_NONNULL_BEGIN

@interface DownloadsPagerVC : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DownloadingVC *downloadingVC;
@property (nonatomic, strong) DownloadedVC *downloadedVC;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END