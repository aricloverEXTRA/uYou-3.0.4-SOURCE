#import "DownloadingInfoButton.h"

@implementation DownloadingInfoButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = [UIFont systemFontOfSize:10];
        _infoLabel.textColor = [UIColor secondaryLabelColor];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_infoLabel];
        
        [NSLayoutConstraint activateConstraints:@[
            [_infoLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [_infoLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [_infoLabel.bottomAnchor constraintEqualToAnchor:self.topAnchor constant:-4]
        ]];
    }
    return self;
}

@end