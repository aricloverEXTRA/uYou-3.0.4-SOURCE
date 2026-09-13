#import "__LNChevronView.h"

@implementation __LNChevronView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isExpanded = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setExpanded:(BOOL)expanded animated:(BOOL)animated {
    _isExpanded = expanded;
    // Chevron rotation animation
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        self.transform = expanded ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
    }];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    CGFloat size = MIN(rect.size.width, rect.size.height) * 0.4;
    
    [path moveToPoint:CGPointMake(centerX - size/2, centerY - size/3)];
    [path addLineToPoint:CGPointMake(centerX, centerY + size/3)];
    [path addLineToPoint:CGPointMake(centerX + size/2, centerY - size/3)];
    
    [[UIColor labelColor] setStroke];
    path.lineWidth = 2.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
}

@end