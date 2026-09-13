#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserButtonCell : UITableViewCell

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END