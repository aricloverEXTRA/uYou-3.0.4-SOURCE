#import "DownloadsManager.h"
@interface DownloadsManager (UYouFixes)
- (BOOL)uyou_ensureMergeableAudioForItem:(id)item phase:(NSString *)phase;
- (BOOL)uyou_remuxWithFFmpegForItem:(id)item phase:(NSString *)phase;
@end
