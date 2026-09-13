#import "uYouInViewGesture.h"

@implementation uYouInViewGesture

- (instancetype)initWithTarget:(id)target action:(SEL)action uYouDelegate:(id<uYouInViewGestureDelegate>)uYouDelegate {
    self = [super initWithTarget:target action:action];
    if (self) {
        _uYouDelegate = uYouDelegate;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    _startLocation = [touch locationInView:self.view];
    _currentLocation = _startLocation;
    self.state = UIGestureRecognizerStateBegan;
    if ([_uYouDelegate respondsToSelector:@selector(inViewGestureDidBegin:)]) {
        [_uYouDelegate inViewGestureDidBegin:self];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    _currentLocation = [touch locationInView:self.view];
    self.state = UIGestureRecognizerStateChanged;
    if ([_uYouDelegate respondsToSelector:@selector(inViewGestureDidChange:)]) {
        [_uYouDelegate inViewGestureDidChange:self];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.state = UIGestureRecognizerStateEnded;
    if ([_uYouDelegate respondsToSelector:@selector(inViewGestureDidEnd:)]) {
        [_uYouDelegate inViewGestureDidEnd:self];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateCancelled;
    if ([_uYouDelegate respondsToSelector:@selector(inViewGestureDidCancel:)]) {
        [_uYouDelegate inViewGestureDidCancel:self];
    }
}

@end