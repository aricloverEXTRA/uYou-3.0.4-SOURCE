#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FRPSettings.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsVC : UIViewController

@property (nonatomic, strong) FRPSettings *settings;

- (instancetype)initWithSettings:(FRPSettings *)settings;
- (void)dismissVC;
- (void)clearDownloading;
- (void)clearDownloaded;

@end

NS_ASSUME_NONNULL_END