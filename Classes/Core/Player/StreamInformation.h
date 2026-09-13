#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StreamInformation : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *formatID;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, copy) NSString *codec;
@property (nonatomic, assign) int64_t bitrate;
@property (nonatomic, assign) CGSize resolution;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL isLive;
@property (nonatomic, copy) NSArray *segments;

- (instancetype)initWithURL:(NSString *)url formatID:(NSString *)formatID mimeType:(NSString *)mimeType codec:(NSString *)codec bitrate:(int64_t)bitrate resolution:(CGSize)resolution duration:(NSTimeInterval)duration isLive:(BOOL)isLive segments:(NSArray *)segments;

@end

NS_ASSUME_NONNULL_END