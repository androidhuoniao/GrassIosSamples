
#import "YZDevRow.h"

NS_ASSUME_NONNULL_BEGIN

// QADDevSection
@interface YZDevSection : NSObject

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) NSMutableArray <YZDevRow *> *rows;

@property (nonatomic, assign, readonly) NSUInteger rowCount;

+ (instancetype)sectionWithTitle:(NSString *)title;

- (void)addRow:(YZDevRow *)row;

- (void)addRows:(NSArray<YZDevRow *> *)rows;

- (void)insertRow:(YZDevRow *)row atIndex:(NSUInteger)idx;

- (void)removeObjectAtIndex:(NSUInteger)index;

- (YZDevRow *)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)setObject:(YZDevRow *)obj atIndexedSubscript:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
