#import "AccountsCell.h"

@implementation AccountsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 20;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_avatarImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_nameLabel];
        
        _emailLabel = [[UILabel alloc] init];
        _emailLabel.font = [UIFont systemFontOfSize:14];
        _emailLabel.textColor = [UIColor secondaryLabelColor];
        _emailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_emailLabel];
        
        [NSLayoutConstraint activateConstraints:@[
            [_avatarImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
            [_avatarImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [_avatarImageView.widthAnchor constraintEqualToConstant:40],
            [_avatarImageView.heightAnchor constraintEqualToConstant:40],
            
            [_nameLabel.leadingAnchor constraintEqualToAnchor:_avatarImageView.trailingAnchor constant:12],
            [_nameLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
            [_nameLabel.bottomAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:-2],
            
            [_emailLabel.leadingAnchor constraintEqualToAnchor:_nameLabel.leadingAnchor],
            [_emailLabel.trailingAnchor constraintEqualToAnchor:_nameLabel.trailingAnchor],
            [_emailLabel.topAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:2]
        ]];
    }
    return self;
}

@end