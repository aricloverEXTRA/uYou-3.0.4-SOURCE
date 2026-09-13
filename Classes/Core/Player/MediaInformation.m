#import "MediaInformation.h"

@implementation MediaInformation

- (instancetype)initWithVideoID:(NSString *)videoID title:(NSString *)title author:(NSString *)author thumbnailURL:(NSString *)thumbnailURL duration:(NSTimeInterval)duration dimensions:(CGSize)dimensions formatID:(NSString *)formatID mimeType:(NSString *)mimeType bitrate:(int64_t)bitrate availableFormats:(NSArray *)availableFormats {
    self = [super init];
    if (self) {
        _videoID = [videoID copy];
        _title = [title copy];
        _author = [author copy];
        _thumbnailURL = [thumbnailURL copy];
        _duration = duration;
        _dimensions = dimensions;
        _formatID = [formatID copy];
        _mimeType = [mimeType copy];
        _bitrate = bitrate;
        _availableFormats = [availableFormats copy];
    }
    return self;
}

@end