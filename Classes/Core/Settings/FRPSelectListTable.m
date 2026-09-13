#import "FRPSelectListTable.h"

@interface FRPSelectListTable () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation FRPSelectListTable

- (instancetype)initWithItems:(NSArray *)items selectedIndex:(NSInteger)selectedIndex {
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        _items = [items copy];
        _selectedIndex = selectedIndex;
        super.dataSource = (id<UITableViewDataSource>)self;
        super.delegate = (id<UITableViewDelegate>)self;
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
    cell.accessoryType = (indexPath.row == _selectedIndex) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    [tableView reloadData];
    if ([_selectDelegate respondsToSelector:@selector(selectListTable:didSelectItemAtIndex:)]) {
        [_selectDelegate selectListTable:self didSelectItemAtIndex:indexPath.row];
    }
}

@end