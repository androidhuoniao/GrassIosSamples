//
//  QLRecordTest.m
//  GrassIosSamplesTests
//
//  Created by grassswwang(王圣伟) on 2020/11/12.
//

#import <XCTest/XCTest.h>
#import "QLReCord.h"


@interface QLRecordTest : XCTestCase
@property (nonatomic,strong) QLReCord *reCord;
@end

@implementation QLRecordTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.reCord =  [[QLReCord alloc] init];
    [self.reCord record];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    [self.reCord addWithIndex:-1];
    XCTAssertEqual(self.reCord.total,0,@"[a1 isEqual:a2] is ture");
    [self.reCord addWithIndex:1];
    XCTAssertEqual(self.reCord.total,1,@"[a1 isEqual:a2] is ture");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
