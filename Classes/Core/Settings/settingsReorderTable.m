#import "settingsReorderTable.h"

@interface settingsReorderTable () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation settingsReorderTable

- (instancetype)initWithItems:(NSArray *)items reorderHandler:(void (^)(NSInteger, NSInteger))handler {
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        _items = [items copy];
        _reorderHandler = [handler copy];
        self.dataSource = (id<UITableViewDataSource>)self;
        self.delegate = (id<UITableViewDelegate>)self;
        self.editing = YES;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = _items[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (_reorderHandler) {
        _reorderHandler(sourceIndexPath.row, destinationIndexPath.row);
    }
}

@end