# MobileFFmpeg (Future: FFmpegKitNext)

This directory is reserved for **FFmpegKitNext** integration to replace the current `FFmpegExecution` wrapper.

## Current State (uYou 3.0.4)
- Uses `Classes/Core/Downloads/FFmpegExecution.m` - custom wrapper around ffmpeg binary
- Bundles ffmpeg binary in `uYouBundle.bundle`
- Limited codec support, manual binary management

## Planned Migration: FFmpegKitNext

**Repository:** https://github.com/tanersener/ffmpeg-kit

### Benefits
- ✅ Native Swift/Obj-C API (no JNI bridge)
- ✅ Modular - only include needed codecs (smaller binary)
- ✅ Hardware acceleration (VideoToolbox, MediaCodec)
- ✅ Active maintenance (FFmpeg 6.x+)
- ✅ SPM/CocoaPods integration
- ✅ Pre-built for iOS (arm64, arm64e, armv7)

### Integration Plan
1. Add FFmpegKitNext via SPM or as vendor static library
2. Replace `FFmpegExecution.m` with `FFmpegKitNext` wrapper
3. Remove bundled ffmpeg binary from `uYouBundle.bundle`
4. Update `DownloadsManager` to use new API
5. Test all download/conversion workflows

### Required Frameworks
- `VideoToolbox` (already in Makefile)
- `AudioToolbox` (already in Makefile)
- `FFmpegKitNext` static library

### Example Usage (Future)
```objc
#import <FFmpegKit/FFmpegKit.h>

- (void)convertVideoWithFFmpegKitNext:(NSString *)inputPath outputPath:(NSString *)outputPath completion:(void (^)(BOOL success))completion {
    NSString *command = [NSString stringWithFormat:@"-i \"%@\" -c:v libx264 -preset fast -crf 23 \"%@\"", inputPath, outputPath];
    [FFmpegKit executeAsync:command withCompleteCallback:^(FFmpegSession *session) {
        completion(session.returnCode == 0);
    }];
}
```

## Files to Update During Migration
- `Classes/Core/Downloads/FFmpegExecution.h/.m` → Replace with FFmpegKitNext wrapper
- `Classes/Core/Downloads/DownloadsManager.m` → Update conversion calls
- `Makefile` → Add FFmpegKitNext library/framework
- `uYouBundle.bundle` → Remove ffmpeg binary