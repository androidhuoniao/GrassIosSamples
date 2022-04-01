
#import <UIKit/UIKit.h>
#import "YZDevButtonCell.h"

@implementation YZDevButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:18];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)updateViewData:(YZDevButtonCellItem *)viewData {
    self.textLabel.text = viewData.title;
    self.textLabel.textColor = viewData.titleColor;
}


@end
