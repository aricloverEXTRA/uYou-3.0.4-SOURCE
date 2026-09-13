#import "FFmpegExecution.h"

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
    // Stub implementation - would use NSTask or similar to run ffmpeg
    if (completionBlock) {
        completionBlock(NO, (NSString *)nil, @"FFmpeg execution not implemented");
    }
}

- (void)cancel {
    _isCancelled = YES;
}

+ (NSString *)ffmpegBinaryPath {
    // Would return path to bundled ffmpeg binary
    return nil;
}

+ (BOOL)isFFmpegAvailable {
    return NO;
}

@end