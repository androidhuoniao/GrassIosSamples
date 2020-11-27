//
//  QADIdfaManagerTest.m
//  GrassIosSamplesTests
//
//  Created by grassswwang(王圣伟) on 2020/11/23.
//

#import <XCTest/XCTest.h>
#import "QADAdConfigManager.h"
#import "QADIdfaManager.h"
#import <OCMock/OCMock.h>


@interface QADIdfaManagerTest : XCTestCase

@end

@implementation QADIdfaManagerTest

- (void)setUp {
    QADAdConfigManager *configManager = [QADAdConfigManager sharedInstance];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"grass" forKey:@"name"];
    [dictionary setValue:@"18" forKey:@"age"];
    [configManager setValue:dictionary forKey:@"jsonObject"];
    id name = [configManager getValue:@"name"];
    id age = [configManager getValue:@"age"];
    NSLog(@"%s name:%@, age:%@",__func__, name,age);
}

- (void)tearDown {
    
}

- (void)testExample {
//    id myObjectMock = OCMPartialMock(myObject);
//
//    // replace (stub) one method on the object
//    OCMStub([myObjectMock writeToDatabase]).andReturn(@YES);
//
//    // call the code under test
//    [myController updateDatabase]
//
//    // verify that the method has been called
//    OCMVerify([myObjectMock writeToDatabase]);
    
    QADAdConfigManager *configManager = [QADAdConfigManager sharedInstance];
    id configManagerMock = OCMPartialMock(configManager);
    OCMStub([configManagerMock enableIDFAAccessRequest]).andReturn(@NO);
}

@end
