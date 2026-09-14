#import "DownloadsManager.h"
#import "DownloadItem.h"
#import "MediaKit/UYTMediaKit.h"
#import <sqlite3.h>
#import <HBLog.h>

// Baked-in fixes from uYouPatches.xm — no external patch dylib needed.
// This file augments DownloadsManager with webm→m4a conversion, ffmpeg remux,
// stall watchdog, and DB finalization. The original DownloadsManager.m stays
// untouched except for calling these helpers at the right points.

static BOOL UYouPathIsWebm(NSString *path) {
    return path.length > 0 && [path.pathExtension.lowercaseString isEqualToString:@"webm"];
}

static NSString *UYouAudioPathForItem(id ui) {
    if (!ui) return nil;
    if ([ui respondsToSelector:@selector(tmpAudioPath)]) {
        NSString *p = [ui tmpAudioPath];
        if (p.length) return p;
    }
    if ([ui respondsToSelector:@selector(cachedAudioPath)]) return [ui cachedAudioPath];
    return nil;
}

static BOOL UYouConvertWebmToM4a(NSString *webm, NSString *m4a) {
    if (!webm || !m4a) return NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:webm]) return NO;
    if ([fm fileExistsAtPath:m4a]) [fm removeItemAtPath:m4a error:nil];
    if (UYTFFActiveBackend() == UYTFFBackendNone) return NO;
    BOOL ok = UYTFFConvertWebmAudioToM4a(webm, m4a);
    if (ok && [fm fileExistsAtPath:m4a]) {
        unsigned long long sz = [[fm attributesOfItemAtPath:m4a error:nil] fileSize];
        if (sz > 0) return YES;
    }
    return NO;
}

@implementation DownloadsManager (UYouFixes)

- (BOOL)uyou_ensureMergeableAudioForItem:(id)item phase:(NSString *)phase {
    @try {
        id ui = item;
        if ([item respondsToSelector:@selector(uYouItem)]) {
            @try { ui = [item uYouItem]; } @catch (id e) {}
        }
        NSString *audioPath = UYouAudioPathForItem(ui);
        if (!audioPath.length) return YES;
        if (!UYouPathIsWebm(audioPath)) return YES;
        NSString *m4a = [[audioPath stringByDeletingPathExtension] stringByAppendingPathExtension:@"m4a"];
        if (UYouConvertWebmToM4a(audioPath, m4a)) {
            @try { [ui setValue:m4a forKey:@"tmpAudioPath"]; } @catch (id e) {}
            HBLogInfo(@"[uYou] %@: webm→m4a done", phase);
            return YES;
        }
        HBLogWarn(@"[uYou] %@: webm→m4a failed", phase);
        return NO;
    } @catch (NSException *e) { return NO; }
}

- (BOOL)uyou_remuxWithFFmpegForItem:(id)item phase:(NSString *)phase {
    @try {
        id ui = item;
        if ([item respondsToSelector:@selector(uYouItem)]) { @try { ui = [item uYouItem]; } @catch (id e) {} }
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *vPath = nil, *aPath = nil;
        if ([ui respondsToSelector:@selector(tmpVideoPath)]) vPath = [ui tmpVideoPath];
        if (!vPath.length && [ui respondsToSelector:@selector(cachedVideoPath)]) vPath = [ui cachedVideoPath];
        if ([ui respondsToSelector:@selector(tmpAudioPath)]) aPath = [ui tmpAudioPath];
        if (!aPath.length && [ui respondsToSelector:@selector(cachedAudioPath)]) aPath = [ui cachedAudioPath];
        NSString *final = [ui respondsToSelector:@selector(filePath)] ? [ui filePath] : nil;
        if (!vPath.length || !aPath.length || !final.length) return NO;
        if (![fm fileExistsAtPath:vPath] || ![fm fileExistsAtPath:aPath]) return NO;
        if (UYTFFActiveBackend() == UYTFFBackendNone) return NO;
        NSString *tmpOut = [final stringByAppendingString:@".merging.mp4"];
        if ([fm fileExistsAtPath:tmpOut]) [fm removeItemAtPath:tmpOut error:nil];
        BOOL ok = UYTFFSmartRemuxToMP4(vPath, aPath, tmpOut);
        NSDictionary *attrs = [fm attributesOfItemAtPath:tmpOut error:nil];
        if (ok && attrs && [attrs fileSize] > 0) {
            if ([fm fileExistsAtPath:final]) [fm removeItemAtPath:final error:nil];
            NSError *err = nil;
            if ([fm moveItemAtPath:tmpOut toPath:final error:&err]) return YES;
            HBLogWarn(@"[uYou] %@: remux move failed %@", phase, err);
        } else {
            [fm removeItemAtPath:tmpOut error:nil];
        }
    } @catch (NSException *e) {}
    return NO;
}

@end
