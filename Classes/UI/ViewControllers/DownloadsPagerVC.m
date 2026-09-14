#import "DownloadsPagerVC.h"
#import "DownloadingVC.h"
#import "DownloadedVC.h"

static DownloadsPagerVC *gDownloadsPagerVC = nil;
static NSUInteger gSelectedTabIndex = 0;

@interface DownloadsPagerVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation DownloadsPagerVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Downloads";
        gDownloadsPagerVC = self;
    }
    return self;
}

- (void)viewPager:(id)viewPager didChangeTabToIndex:(NSUInteger)idx fromTabIndex:(NSUInteger)fromIdx {
    gSelectedTabIndex = idx;
}

- (NSArray<UIViewController *> *)viewControllers {
    NSMutableArray *arr = [NSMutableArray array];
    if (_downloadingVC) [arr addObject:_downloadingVC];
    if (_downloadedVC) [arr addObject:_downloadedVC];
    return arr;
}

- (void)updatePageStyles {
    [super updateViewConstraints];
    for (UIViewController *vc in self.viewControllers) {
        if ([vc respondsToSelector:@selector(updatePageStyles)]) [vc performSelector:@selector(updatePageStyles)];
        if ([vc respondsToSelector:@selector(tableView)]) {
            UITableView *tv = [vc performSelector:@selector(tableView)];
            for (UITableViewCell *cell in tv.visibleCells) if ([cell respondsToSelector:@selector(updatePageStyles)]) [cell performSelector:@selector(updatePageStyles)];
        }
    }
    for (UIView *sub in self.view.subviews) if ([sub isKindOfClass:[UIScrollView class]]) {
        UIScrollView *tabs = (UIScrollView *)sub;
        NSUInteger i = 0;
        for (UIView *item in tabs.subviews) if ([item isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)item;
            if (i != gSelectedTabIndex) {
                @try { [lab setTextColor:[UILabel performSelector:@selector(_defaultColor)]]; } @catch (id e) {}
            }
            i++;
        }
    }
}

void UYouRefreshAppearance(void) {
    if (!gDownloadsPagerVC) return;
    @try { [gDownloadsPagerVC updatePageStyles]; } @catch (NSException *e) {}
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