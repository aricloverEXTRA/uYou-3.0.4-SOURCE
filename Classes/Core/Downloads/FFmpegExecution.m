#import "FFmpegExecution.h"
#import "MediaKit/UYTMediaKit.h"
#import <dlfcn.h>
#import <objc/runtime.h>

@implementation FFmpegExecution

- (instancetype)initWithInputPath:(NSString *)inputPath outputPath:(NSString *)outputPath arguments:(NSArray<NSString *> *)arguments {
    self = [super init];
    if (self) {
        _inputPath = [inputPath copy];
        _outputPath = [outputPath copy];
        _arguments = [arguments copy];
        _isCancelled = NO;
    }
    return self;
}

- (void)executeWithProgress:(FFmpegProgressBlock)progressBlock completion:(FFmpegCompletionBlock)completionBlock {
    if (_isCancelled) {
        if (completionBlock) completionBlock(NO, nil, @"Cancelled");
        return;
    }
    NSArray *args = _arguments;
    if (!args.count) {
        if (_inputPath && _outputPath) args = @[@"-i", _inputPath, @"-y", _outputPath];
    }
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        if (self.isCancelled) {
            dispatch_async(dispatch_get_main_queue(), ^{ if (completionBlock) completionBlock(NO, nil, @"Cancelled"); });
            return;
        }
        BOOL ok = UYTFFRun(args);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.isCancelled) { if (completionBlock) completionBlock(NO, nil, @"Cancelled"); return; }
            if (ok) { if (completionBlock) completionBlock(YES, self.outputPath, nil); }
            else { if (completionBlock) completionBlock(NO, nil, @"FFmpeg failed"); }
        });
    });
}

- (void)cancel { _isCancelled = YES; }

+ (NSString *)ffmpegBinaryPath { return nil; }
+ (BOOL)isFFmpegAvailable { return UYTFFActiveBackend() != UYTFFBackendNone; }

@end
