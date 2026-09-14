#import "SettingsVC.h"
#import "boolSettingsVC.h"

@interface SettingsVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingsVC

- (instancetype)initWithSettings:(FRPSettings *)settings {
    self = [super init];
    if (self) {
        _settings = settings;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _settings.title;
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissVC)];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearDownloading {
    NSString *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dbPath = [docs stringByAppendingPathComponent:@"uyoudb.sqlite"];
    @try {
        [[NSFileManager defaultManager] removeItemAtPath:dbPath error:nil];
        // Also clear in-memory queue if DownloadsManager is available
        Class dm = NSClassFromString(@"DownloadsManager");
        if (dm && [dm respondsToSelector:@selector(sharedInstance)]) {
            id mgr = [dm performSelector:@selector(sharedInstance)];
            if ([mgr respondsToSelector:@selector(setDownloadingItems:)]) [mgr performSelector:@selector(setDownloadingItems:) withObject:@[]];
        }
    } @catch (id e) {}
    [_tableView reloadData];
}

- (void)clearDownloaded {
    NSString *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dlDir = [docs stringByAppendingPathComponent:@"uYouDownloads"];
    @try {
        for (NSString *f in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dlDir error:nil]) {
            [[NSFileManager defaultManager] removeItemAtPath:[dlDir stringByAppendingPathComponent:f] error:nil];
        }
    } @catch (id e) {}
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _settings.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FRPSection *frpSection = _settings.sections[section];
    return frpSection.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FRPSection *frpSection = _settings.sections[indexPath.section];
    id item = frpSection.items[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if ([item isKindOfClass:[boolSettingsVC class]]) {
        boolSettingsVC *boolItem = (boolSettingsVC *)item;
        cell.textLabel.text = boolItem.title;
        cell.detailTextLabel.text = boolItem.currentValue ? @"On" : @"Off";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FRPSection *frpSection = _settings.sections[section];
    return frpSection.title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    FRPSection *frpSection = _settings.sections[section];
    return frpSection.footer;
}

@end