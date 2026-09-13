#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRPSliderCell : UITableViewCell

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END