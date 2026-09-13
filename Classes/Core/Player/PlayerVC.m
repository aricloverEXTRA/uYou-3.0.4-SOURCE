#import "PlayerVC.h"
#import "PlayerManager.h"

@interface PlayerVC ()

@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIView *controlsView;

@end

@implementation PlayerVC

- (instancetype)initWithMediaInformation:(MediaInformation *)mediaInfo {
    self = [super init];
    if (self) {
        _mediaInformation = mediaInfo;
        _isFullscreen = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:[[PlayerManager sharedManager] player]];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:_playerLayer];
    
    [[PlayerManager sharedManager] playWithMediaInformation:_mediaInformation];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _playerLayer.frame = self.view.bounds;
}

- (void)enterFullscreen {
    _isFullscreen = YES;
    // Implementation for fullscreen
}

- (void)exitFullscreen {
    _isFullscreen = NO;
    // Implementation for exiting fullscreen
}

@end