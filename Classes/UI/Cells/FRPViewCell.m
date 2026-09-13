#import "FRPViewCell.h"

@implementation FRPViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_titleLabel];
        
        [NSLayoutConstraint activateConstraints:@[
            [_titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
            [_titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]
        ]];
    }
    return self;
}

- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    if (customView) {
        customView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:customView];
        [NSLayoutConstraint activateConstraints:@[
            [customView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
            [customView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]
        ]];
    }
}

@end