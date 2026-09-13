#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArtworkImageView : UIImageView

@property (nonatomic, assign) BOOL isAnimating;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END