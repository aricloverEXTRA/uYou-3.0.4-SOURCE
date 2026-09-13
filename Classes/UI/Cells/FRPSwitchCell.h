#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRPSwitchCell : UITableViewCell

@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END