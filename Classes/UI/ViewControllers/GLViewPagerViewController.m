#import "GLViewPagerViewController.h"

@interface GLViewPagerViewController () <UIScrollViewDelegate>

@end

@implementation GLViewPagerViewController

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers {
    self = [super init];
    if (self) {
        _viewControllers = viewControllers;
        _currentPage = 0;
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
    _scrollView.contentSize = CGSizeMake(_viewControllers.count * self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_scrollView];
    
    for (NSInteger i = 0; i < _viewControllers.count; i++) {
        UIViewController *vc = _viewControllers[i];
        vc.view.frame = CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.bounds.size.width;
    _currentPage = (NSInteger)((scrollView.contentOffset.x + pageWidth / 2) / pageWidth);
}

- (void)setCurrentPage:(NSInteger)page animated:(BOOL)animated {
    if (page >= 0 && page < _viewControllers.count) {
        CGFloat x = page * self.view.bounds.size.width;
        [_scrollView setContentOffset:CGPointMake(x, 0) animated:animated];
    }
}

@end