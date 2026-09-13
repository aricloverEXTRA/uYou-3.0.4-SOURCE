#import "uYouPanGestureRecognizer.h"

@implementation uYouPanGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action threshold:(CGFloat)threshold {
    self = [super initWithTarget:target action:action];
    if (self) {
        _isThresholdExceeded = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    _initialTouchPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGFloat distance = hypot(currentPoint.x - _initialTouchPoint.x, currentPoint.y - _initialTouchPoint.y);
    _isThresholdExceeded = distance > 10.0; // Default threshold
}

@end