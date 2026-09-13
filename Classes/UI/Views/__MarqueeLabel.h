#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface __MarqueeLabel : UILabel

@property (nonatomic, assign) CGFloat scrollSpeed;
@property (nonatomic, assign) BOOL isScrolling;
@property (nonatomic, assign) NSTimeInterval pauseDuration;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)startScrolling;
- (void)stopScrolling;

@end

NS_ASSUME_NONNULL_END