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

- (void)startAnimating {
    _isAnimating = YES;
    // Animation implementation
}

- (void)stopAnimating {
    _isAnimating = NO;
    // Stop animation
}

@end