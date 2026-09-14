#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MediaInformation.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerVCDelegate <NSObject>
@optional
- (void)playerVCDidClose:(id)playerVC;
- (void)playerVCDidFinishPlaying:(id)playerVC;
@end

@interface PlayerVC : UIViewController

@property (nonatomic, weak) id<PlayerVCDelegate> delegate;
@property (nonatomic, strong) MediaInformation *mediaInformation;
@property (nonatomic, assign) BOOL isFullscreen;

- (instancetype)initWithMediaInformation:(MediaInformation *)mediaInfo;
- (void)enterFullscreen;
- (void)exitFullscreen;
- (void)close;

@end

NS_ASSUME_NONNULL_END