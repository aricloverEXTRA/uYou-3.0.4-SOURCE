#import "__FakeMarqueeLabel.h"

@implementation __FakeMarqueeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollSpeed = 30.0;
        _isScrolling = NO;
        self.numberOfLines = 1;
    }
    return self;
}

- (void)startScrolling {
    _isScrolling = YES;
    // Marquee scrolling implementation
}

- (void)stopScrolling {
    _isScrolling = NO;
    // Stop scrolling
}

@end