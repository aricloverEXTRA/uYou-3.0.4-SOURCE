#import "ArtworkImageView.h"

@implementation ArtworkImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isAnimating = NO;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (UIImageView *)imageView {
    UIImageView *iv = (UIImageView *)self;
    iv.contentMode = UIViewContentModeScaleAspectFit;
    UIView *parent = iv.superview;
    if (parent && !parent.translatesAutoresizingMaskIntoConstraints) {
        [parent.leftAnchor constraintEqualToAnchor:parent.superview.leftAnchor constant:16].active = YES;
        [parent.rightAnchor constraintEqualToAnchor:parent.superview.rightAnchor constant:-16].active = YES;
    }
    return iv;
}

- (void)startAnimating {
    _isAnimating = YES;
}

- (void)stopAnimating {
    _isAnimating = NO;
}

@end