#import <UIKit/UIKit.h>
#import <substrate.h>
#import <YouTubeHeader/YTIPivotBarRenderer.h>
#import <YouTubeHeader/YTIPivotBarSupportedRenderers.h>
#import <YouTubeHeader/YTIPivotBarItemRenderer.h>

@interface YTPivotBarView : UIView
- (void)setRenderer:(YTIPivotBarRenderer *)renderer;
@end

@interface YTSettingsViewController : UIViewController
- (void)setSectionItems:(id)items forCategory:(id)category title:(id)title icon:(id)icon titleDescription:(id)titleDescription headerHidden:(BOOL)headerHidden;
@end

@interface DownloadsPagerVC : UIViewController
- (instancetype)init;
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

%ctor {
    %init();
}
