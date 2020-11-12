//
//  QLReCord.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/12.
//

#import "QLReCord.h"
@interface QLReCord()
@property (nonatomic,strong) NSMutableArray *reCordList;
@end

@implementation QLReCord
- (void)record {
    if (self.reCordList == nil) {
        self.reCordList = [[NSMutableArray alloc] init];
    }
}

- (void)addWithIndex:(NSInteger)index {
    if (index <  0) {
        return;
    }
    [self.reCordList addObject:@(index)];
}

-(NSInteger)total {
    return self.reCordList.count;
}

@end
