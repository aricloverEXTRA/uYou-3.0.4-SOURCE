#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface __FakeMarqueeLabel : UILabel

@property (nonatomic, assign) CGFloat scrollSpeed;
@property (nonatomic, assign) BOOL isScrolling;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)startScrolling;
- (void)stopScrolling;

@end

NS_ASSUME_NONNULL_END