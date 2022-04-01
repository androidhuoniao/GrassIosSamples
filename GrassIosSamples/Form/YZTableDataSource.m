
#import "YZTableDataSource.h"

@interface YZTableDataSource()

/// dict
@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <YZDevSection *>*form;

@end

// QADTableDataSource
@implementation YZTableDataSource

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.form.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.form[section].rowCount;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.form[section].title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZDevRow *row = [self rowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row.reuseIdentifier forIndexPath:indexPath];
    [row updateCell:cell];
    return cell;
}

- (YZDevRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    return self.form[indexPath.section][indexPath.row];
}

- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
    return [self rowAtIndexPath:indexPath].model;
}

- (NSMutableArray<YZDevSection *> *)form {
    if (!_form) {
        _form = NSMutableArray.array;
    }
    return _form;
}

@end
