#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRPViewCell : UITableViewCell

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END