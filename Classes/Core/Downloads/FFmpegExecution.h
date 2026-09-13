#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^FFmpegProgressBlock)(double progress);
typedef void (^FFmpegCompletionBlock)(BOOL success, NSString * _Nullable outputPath, NSString * _Nullable error);

@interface FFmpegExecution : NSObject

@property (nonatomic, copy) NSString *inputPath;
@property (nonatomic, copy) NSString *outputPath;
@property (nonatomic, copy) NSArray<NSString *> *arguments;
@property (nonatomic, assign) BOOL isCancelled;

- (instancetype)initWithInputPath:(NSString *)inputPath outputPath:(NSString *)outputPath arguments:(NSArray<NSString *> *)arguments;
- (void)executeWithProgress:(FFmpegProgressBlock)progressBlock completion:(FFmpegCompletionBlock)completionBlock;
- (void)cancel;

+ (NSString * _Nullable)ffmpegBinaryPath;
+ (BOOL)isFFmpegAvailable;

@end

NS_ASSUME_NONNULL_END