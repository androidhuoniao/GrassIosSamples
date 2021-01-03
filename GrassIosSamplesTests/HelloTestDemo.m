//
//  HelloTestDemo.m
//  GrassIosSamplesTests
//
//  Created by 王圣伟 on 2021/1/3.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@interface HelloTestDemo : XCTestCase

@end

/**
 这个类主要是用来学习XCTest的一些语法
 */
@implementation HelloTestDemo

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    XCTAssertLessThan(1, 2);
    XCTAssertEqual(@"1",@"1",@"1");
    XCTAssertNotEqual(@"1", @"2");
    XCTAssertGreaterThan(2, 1);
}

@end
