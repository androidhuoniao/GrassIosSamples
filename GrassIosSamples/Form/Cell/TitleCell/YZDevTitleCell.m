
#import <UIKit/UIKit.h>
#import "YZDevTitleCell.h"

@implementation YZDevTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)updateViewData:(YZDevTitleCellItem *)viewData {
    self.accessoryType = viewData.selector ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    self.textLabel.font = viewData.titleFont;
    self.textLabel.text = viewData.title;
    self.textLabel.textColor = viewData.titleColor;
}

@end
