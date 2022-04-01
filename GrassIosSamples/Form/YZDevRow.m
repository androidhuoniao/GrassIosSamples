
#import "YZDevRow.h"

@interface YZDevRow()

@property (nonatomic, strong, readwrite) Class cellClass;

@property (nonatomic, strong, readwrite) id model;

@end

@implementation YZDevRow

+ (instancetype)rowWithClass:(Class)cls {
    return [[self alloc] initWithClass:cls model:nil];
}

+ (instancetype)rowWithClass:(Class)cls model:(id)model {
    return [[self alloc] initWithClass:cls model:model];
}

- (instancetype)initWithClass:(Class)cls model:(id)model {
    if (self = [super init]) {
        self.cellClass = cls;
        self.model = model;
    }
    return self;
}

- (void)updateCell:(UIView *)cell {
    if ([cell respondsToSelector:@selector(updateViewData:)]) {
        [(id<YZDevUpdatable>)cell updateViewData: self.model];
    }
}

- (NSString *)reuseIdentifier {
    return [NSString stringWithFormat:@"%@", self.cellClass];
}

@end
