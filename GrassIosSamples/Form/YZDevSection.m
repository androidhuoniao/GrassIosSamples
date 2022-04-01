
#import "YZDevSection.h"

@interface YZDevSection()

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSMutableArray <YZDevRow *> *rows;

@end


// QADDevSection
@implementation YZDevSection

+ (instancetype)sectionWithTitle:(NSString *)title {
    YZDevSection *section = YZDevSection.new;
    section.title = title;
    return section;
}

- (NSUInteger)rowCount {
    return self.rows.count;
}

- (void)insertRow:(YZDevRow *)row atIndex:(NSUInteger)idx {
    [self.rows insertObject:row atIndex:idx];
}

- (void)addRow:(YZDevRow *)row {
    [self.rows addObject:row];
}

- (void)addRows:(NSArray<YZDevRow *> *)rows {
    [self.rows addObjectsFromArray:rows];
}

- (YZDevRow *)objectAtIndexedSubscript:(NSUInteger)idx {
    return self.rows[idx];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.rows removeObjectAtIndex:index];
}

- (void)setObject:(YZDevRow *)obj atIndexedSubscript:(NSUInteger)idx {
    self.rows[idx] = obj;
}

- (NSMutableArray<YZDevRow *> *)rows {
    if (!_rows) {
        _rows = NSMutableArray.array;
    }
    return _rows;
}

- (NSString *)description {
    return self.rows.description;
}

@end
