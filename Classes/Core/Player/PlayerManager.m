#import "PlayerManager.h"

@interface PlayerManager ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *currentItem;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) id timeObserver;

@end

@implementation PlayerManager

+ (instancetype)sharedManager {
    static PlayerManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _player = [[AVPlayer alloc] init];
        _isPlaying = NO;
    }
    return self;
}

- (void)playWithMediaInformation:(MediaInformation *)mediaInfo {
    NSURL *url = [NSURL URLWithString:mediaInfo.formatID]; // Simplified
    [self playWithURL:url];
}

- (void)playWithURL:(NSURL *)url {
    _currentItem = [AVPlayerItem playerItemWithURL:url];
    [_player replaceCurrentItemWithPlayerItem:_currentItem];
    [_player play];
    _isPlaying = YES;
    
    __weak typeof(self) weakSelf = self;
    _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if ([weakSelf.delegate respondsToSelector:@selector(playerManager:didUpdateTime:duration:)]) {
            [weakSelf.delegate playerManager:weakSelf didUpdateTime:time duration:weakSelf.currentItem.duration];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        weakSelf.isPlaying = NO;
        if ([weakSelf.delegate respondsToSelector:@selector(playerManagerDidFinishPlaying:)]) {
            [weakSelf.delegate playerManagerDidFinishPlaying:weakSelf];
        }
    }];
}

- (void)pause {
    [_player pause];
    _isPlaying = NO;
}

- (void)seekToTime:(CMTime)time completionHandler:(void (^)(BOOL finished))completion {
    [_player seekToTime:time completionHandler:completion];
}

- (void)setRate:(float)rate {
    _player.rate = rate;
}

- (void)setVolume:(float)volume {
    _player.volume = volume;
}

@end