#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRPViewSection : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIView *view;

- (instancetype)initWithTitle:(NSString *)title view:(UIView *)view;

@end

NS_ASSUME_NONNULL_END