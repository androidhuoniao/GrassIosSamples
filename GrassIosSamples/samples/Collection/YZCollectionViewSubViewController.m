//
//  YZCollectionViewSubViewController.m
//  GrassIosSamples
//
//  Created by grassswwang on 2022/4/1.
//

#import "YZCollectionViewSubViewController.h"
#import "YZDevTitleCellItem.h"
#import "YZDevRow.h"
#import "YZDevTitleCell.h"

@interface YZCollectionViewSubViewController () <UITableViewDelegate>

@end

@implementation YZCollectionViewSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initSubviews {
    NSArray <NSDictionary *> *sections = @[
        @{
            @"开发者": @"showDevelop"
        },

    ];
    NSMutableArray *form = NSMutableArray.array;
    for (NSDictionary *section in sections) {
        NSMutableArray *rows = [NSMutableArray array];
        for (NSString *key in section) {
            YZDevTitleCellItem *item = [[YZDevTitleCellItem alloc] init];
            [item addTitle:key];
            [item addSelector:NSSelectorFromString(section[key])];
            [rows addObject:[YZDevRow rowWithClass:YZDevTitleCell.class model:item]];
        }
        [form addObject:rows];
    }
    self.form = form.copy;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 66;
}

- (void)showDevelop {
//    [self showViewController:QADDeveloperVC.new sender:nil];
}

- (void)showHotAreaDebug {
//    QADExpListVC *expListVC = QADExpListVC.new;
//    [self showViewController:expListVC sender:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YZDevTitleCellItem *item = [self rowAtIndexPath:indexPath].model;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:item.selector];
#pragma clang diagnostic pop
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
