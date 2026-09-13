#import <UIKit/UIKit.h>
#import <substrate.h>
#import <YouTubeHeader/YTIPivotBarRenderer.h>
#import <YouTubeHeader/YTIPivotBarSupportedRenderers.h>
#import <YouTubeHeader/YTIPivotBarItemRenderer.h>
#import <YouTubeHeader/YTAppViewController.h>
#import <YouTubeHeader/YTPageStyleController.h>
#import <YouTubeHeader/YTPlaybackConfig.h>
#import <YouTubeHeader/YTPlayerViewController.h>
#import <YouTubeHeader/YTMainAppVideoPlayerOverlayViewController.h>
#import <YouTubeHeader/YTAppDelegate.h>
#import <YouTubeHeader/YTLocalPlaybackController.h>
#import <YouTubeHeader/YTHeaderContentComboViewController.h>
#import <YouTubeHeader/YTRefactoredHeaderContentComboViewController.h>
#import <YouTubeHeader/YTInlineMutedPlaybackWatchController.h>
#import <YouTubeHeader/YTAppViewController.h>

@interface YTPivotBarView : UIView
- (void)setRenderer:(YTIPivotBarRenderer *)renderer;
@end

@interface YTSettingsViewController : UIViewController
- (void)setSectionItems:(id)items forCategory:(id)category title:(id)title icon:(id)icon titleDescription:(id)titleDescription headerHidden:(BOOL)headerHidden;
@end

@interface DownloadsPagerVC : UIViewController
- (instancetype)init;
@end

@interface YTHeaderContentComboViewController : UIViewController
@end

@interface YTRefactoredHeaderContentComboViewController : UIViewController
@end

@interface YTAppViewController : UIViewController
- (void)closeMiniPlayer;
@end

@interface YTPageStyleController : NSObject
+ (void)updatePageStyles;
@end

@interface YTInlineMutedPlaybackWatchController : NSObject
- (void)startPlayback;
@end

@interface YTPlaybackConfig : NSObject
- (void)setStartPlayback:(id)arg1;
@end

@interface YTPlayerViewController : UIViewController
- (void)updatePlayerViewWithActivePlayerOverlay;
@end

@interface YTMainAppVideoPlayerOverlayViewController : UIViewController
- (void)mediaTime;
- (void)setMediaTime:(id)arg1;
@end

@interface YTAppDelegate : UIResponder
- (BOOL)application:(id)application didFinishLaunchingWithOptions:(id)options;
@end

@interface YTLocalPlaybackController : NSObject
- (id)currentVideoID;
@end

@interface Statistics : NSObject
+ (void)update:(id)arg1;
@end

%hook YTPivotBarView

- (void)setRenderer:(YTIPivotBarRenderer *)renderer {
    %orig(renderer);
    
    // Add uYou tab to pivot bar
    if (renderer) {
        YTIPivotBarSupportedRenderers *uYouTab = [%c(YTIPivotBarRenderer) pivotSupportedRenderersWithBrowseId:@"FEuYou" title:@"uYou" iconType:123];
        if (uYouTab) {
            NSMutableArray *items = [renderer itemsArray];
            if (items) {
                NSMutableArray *mutableItems = [items mutableCopy];
                [mutableItems addObject:uYouTab];
                [renderer setItemsArray:mutableItems];
            }
        }
    }
}

%end

%hook YTSettingsViewController

- (void)setSectionItems:(id)items forCategory:(id)category title:(id)title icon:(id)icon titleDescription:(id)titleDescription headerHidden:(BOOL)headerHidden {
    %orig(items, category, title, icon, titleDescription, headerHidden);
    
    // Add uYou section to settings
    if ([title isEqualToString:@"General"]) {
        // Add uYou settings section
    }
}

%end

%hook YTHeaderContentComboViewController

- (void)viewDidLoad {
    %orig;
    // Customize player header - hide unwanted buttons, add uYou buttons
    // Hide: remix, share, clip, etc.
    // Add: download, quality, speed, loop buttons
}

%end

%hook YTRefactoredHeaderContentComboViewController

- (void)viewDidLoad {
    %orig;
    // Same customization for refactored header
}

%end

%hook YTAppViewController

- (void)closeMiniPlayer {
    %orig;
    // Handle mini player close - cleanup uYou state
}

%end

%hook YTPageStyleController

+ (void)updatePageStyles {
    %orig;
    // Disable shorts tab, enable uYou page styles
    // Hide shorts shelf, enable uYou tabs
}

%end

%hook YTInlineMutedPlaybackWatchController

- (void)startPlayback {
    %orig;
    // Handle muted playback start - uYou quality/speed settings
}

%end

%hook YTPlaybackConfig

- (void)setStartPlayback:(id)arg1 {
    %orig(arg1);
    // Apply uYou playback settings (quality, speed, codec)
}

%end

%hook YTPlayerViewController

- (void)updatePlayerViewWithActivePlayerOverlay {
    %orig;
    // Update player overlay with uYou controls
}

%end

%hook YTMainAppVideoPlayerOverlayViewController

- (void)mediaTime {
    %orig;
    // uYou media time tracking
}

- (void)setMediaTime:(id)arg1 {
    %orig(arg1);
    // uYou media time setting
}

%end

%hook YTAppDelegate

- (BOOL)application:(id)application didFinishLaunchingWithOptions:(id)options {
    BOOL result = %orig(application, options);
    // Initialize uYou on app launch
    return result;
}

%end

%hook YTLocalPlaybackController

- (id)currentVideoID {
    id result = %orig;
    // uYou video ID tracking for downloads
    return result;
}

%end

%hook Statistics

+ (void)update:(id)arg1 {
    %orig(arg1);
    // uYou statistics tracking
}

%end

%ctor {
    %init();
}
