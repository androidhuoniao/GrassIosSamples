
#import <UIKit/UIKit.h>
#import "YZDevSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface YZTableDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong, readonly) NSMutableArray <YZDevSection *>*form;

- (YZDevRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

- (id)modelAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
