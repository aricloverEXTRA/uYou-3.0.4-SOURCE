#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediaInformation : NSObject

@property (nonatomic, copy) NSString *videoID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) CGSize dimensions;
@property (nonatomic, copy) NSString *formatID;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, assign) int64_t bitrate;
@property (nonatomic, copy) NSArray *availableFormats;

- (instancetype)initWithVideoID:(NSString *)videoID title:(NSString *)title author:(NSString *)author thumbnailURL:(NSString *)thumbnailURL duration:(NSTimeInterval)duration dimensions:(CGSize)dimensions formatID:(NSString *)formatID mimeType:(NSString *)mimeType bitrate:(int64_t)bitrate availableFormats:(NSArray *)availableFormats;

@end

NS_ASSUME_NONNULL_END