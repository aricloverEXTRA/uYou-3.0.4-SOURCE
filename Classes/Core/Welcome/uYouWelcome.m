#import "uYouWelcome.h"

@interface uYouWelcome () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation uYouWelcome

- (instancetype)initWithFirstLaunch:(BOOL)isFirstLaunch {
    self = [super init];
    if (self) {
        _isFirstLaunch = isFirstLaunch;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_pageControl];
    
    [NSLayoutConstraint activateConstraints:@[
        [_pageControl.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [_pageControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
    
    // Add welcome pages
    for (NSInteger i = 0; i < 3; i++) {
        UIView *page = [[UIView alloc] initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        UILabel *label = [[UILabel alloc] initWithFrame:page.bounds];
        label.text = [NSString stringWithFormat:@"Welcome to uYou %ld", (long)i + 1];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:24];
        [page addSubview:label];
        [_scrollView addSubview:page];
    }
    
    _scrollView.contentSize = CGSizeMake(3 * self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)showWelcome {
    // Present welcome
}

- (void)skipWelcome {
    if ([_delegate respondsToSelector:@selector(welcomeDidSkip:)]) {
        [_delegate welcomeDidSkip:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.bounds.size.width;
    _pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / pageWidth);
}

@end