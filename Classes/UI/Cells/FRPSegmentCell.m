#import "FRPSegmentCell.h"

@implementation FRPSegmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_titleLabel];
        
        _segmentedControl = [[UISegmentedControl alloc] init];
        _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_segmentedControl];
        
        [NSLayoutConstraint activateConstraints:@[
            [_titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
            [_titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            
            [_segmentedControl.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
            [_segmentedControl.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [_segmentedControl.widthAnchor constraintEqualToConstant:150]
        ]];
    }
    return self;
}

@end