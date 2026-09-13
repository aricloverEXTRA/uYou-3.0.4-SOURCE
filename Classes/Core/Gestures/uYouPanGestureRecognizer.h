#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface uYouPanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, assign) CGPoint initialTouchPoint;
@property (nonatomic, assign) BOOL isThresholdExceeded;

- (instancetype)initWithTarget:(id)target action:(SEL)action threshold:(CGFloat)threshold;

@end

NS_ASSUME_NONNULL_END