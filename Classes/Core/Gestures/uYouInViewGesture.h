#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol uYouInViewGestureDelegate <NSObject>
@optional
- (void)inViewGestureDidBegin:(id)gesture;
- (void)inViewGestureDidChange:(id)gesture;
- (void)inViewGestureDidEnd:(id)gesture;
- (void)inViewGestureDidCancel:(id)gesture;
@end

@interface uYouInViewGesture : UIGestureRecognizer

@property (nonatomic, weak) id<uYouInViewGestureDelegate> uYouDelegate;
@property (nonatomic, assign) CGPoint startLocation;
@property (nonatomic, assign) CGPoint currentLocation;
@property (nonatomic, assign) CGFloat velocity;

- (instancetype)initWithTarget:(id)target action:(SEL)action uYouDelegate:(id<uYouInViewGestureDelegate>)uYouDelegate;

@end

NS_ASSUME_NONNULL_END