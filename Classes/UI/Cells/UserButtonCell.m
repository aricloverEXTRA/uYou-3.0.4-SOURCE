#import "UserButtonCell.h"

@implementation UserButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_titleLabel];
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_button];
        
        [NSLayoutConstraint activateConstraints:@[
            [_titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
            [_titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            
            [_button.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
            [_button.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [_button.widthAnchor constraintEqualToConstant:80],
            [_button.heightAnchor constraintEqualToConstant:30]
        ]];
    }
    return self;
}

@end