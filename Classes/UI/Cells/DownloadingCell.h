#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadingCell : UITableViewCell

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *cancelButton;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;
- (void)updatePageStyles;

@end

NS_ASSUME_NONNULL_END