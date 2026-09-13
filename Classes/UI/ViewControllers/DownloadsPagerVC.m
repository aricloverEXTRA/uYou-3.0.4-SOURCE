#import "DownloadsPagerVC.h"
#import "DownloadingVC.h"
#import "DownloadedVC.h"

@interface DownloadsPagerVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation DownloadsPagerVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Downloads";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Downloading", @"Downloaded"]];
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(2 * self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_scrollView];
    
    _downloadingVC = [[DownloadingVC alloc] init];
    _downloadingVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self addChildViewController:_downloadingVC];
    [_scrollView addSubview:_downloadingVC.view];
    [_downloadingVC didMoveToParentViewController:self];
    
    _downloadedVC = [[DownloadedVC alloc] init];
    _downloadedVC.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self addChildViewController:_downloadedVC];
    [_scrollView addSubview:_downloadedVC.view];
    [_downloadedVC didMoveToParentViewController:self];
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    CGFloat x = sender.selectedSegmentIndex * self.view.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.bounds.size.width;
    _segmentedControl.selectedSegmentIndex = (NSInteger)(scrollView.contentOffset.x / pageWidth);
}

@end