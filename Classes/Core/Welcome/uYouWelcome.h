#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol uYouWelcomeDelegate <NSObject>
@optional
- (void)welcomeDidFinish:(id)welcome;
- (void)welcomeDidSkip:(id)welcome;
@end

@interface uYouWelcome : UIViewController

@property (nonatomic, weak) id<uYouWelcomeDelegate> delegate;
@property (nonatomic, assign) BOOL isFirstLaunch;

- (instancetype)initWithFirstLaunch:(BOOL)isFirstLaunch;
- (void)showWelcome;
- (void)skipWelcome;

@end

NS_ASSUME_NONNULL_END