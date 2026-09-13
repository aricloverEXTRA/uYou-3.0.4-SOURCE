#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface __LNChevronView : UIView

@property (nonatomic, assign) BOOL isExpanded;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setExpanded:(BOOL)expanded animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END