#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadingInfoButton : UIButton

@property (nonatomic, strong) UILabel *infoLabel;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END