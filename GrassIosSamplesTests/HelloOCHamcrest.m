//
//  HelloOCHamcrest.m
//  GrassIosSamplesTests
//
//  Created by 王圣伟 on 2021/1/16.
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>

@interface HelloOCHamcrest : XCTestCase

@end

@implementation HelloOCHamcrest

- (void)helloApi{
    NSString *string =@"FooBar";
    assertThat(string, is(@"Foo"));    //判断字符串是否相等

    assertThat(string, startsWith(@"Foo")); //判断字符串是否以“Foo”开始
    assertThat(string, endsWith(@"Bar"));   //判断字符串是否以“Bar”结束
    assertThat(string, containsSubstring(@"oo"));   //判断是否包含字符串“oo”
    assertThat(string, equalToIgnoringCase(@"foobar")); //忽略大小写的比较
//    assertThat(@" X \n  Y \n  Z  \n", equalToIgnoringWhiteSpace(@"X Y Z"));   //忽略空白字符的比较

    //多个条件的组合
    NSString * string1 = @"FooBar";
    assertThat(string1, allOf(startsWith(@"Foo"),endsWith(@"Bar"),nil));   //逻辑与组合
    assertThat(string1, anyOf(startsWith(@"Foo"),startsWith(@"Bar"),nil));//逻辑与组合
    assertThat(string1, anyOf(startsWith(@"Foo"),endsWith(@"Bar"),nil));   //逻辑与组合


    //与isNot相关的
    NSString *string2 = @"FooBar";
    assertThat(string2, isNot(@"foo")); //不相等
    assertThat(string2, isNot(endsWith(@"Baz")));  //不是以"Baz"结尾

    //与nil相关的
    NSObject *obj =nil;
    assertThat(obj, nilValue());   //为空
    assertThat(obj, notNilValue());  //不为空

    //判断是否是同一类型的class
    NSString *string3 =@"FooBar";
    assertThat(string3, instanceOf([NSString class]));


    //与数值相关的判断
    assertThatInt(5, equalToInt(5));  //int类型
    assertThatFloat(3.14, equalToFloat(3.14f));    //浮点型的


    //与NSNumber 相关的
    NSNumber *f =[NSNumber numberWithFloat:3.14f];
    assertThat(f,closeTo(3.0f, 0.25f));  //接近3.0，范围在0.25以内

    assertThat(f, lessThan([NSNumber numberWithInt:4]));  //比4小
    assertThat(f, greaterThan([NSNumber numberWithInt:3]));  //比3大


    //与数组相关的
    NSArray *arr =[NSArray array];

    assertThat(arr, isEmpty());  //为空
    assertThat(arr, hasCountOf(0));  //长度为0

    NSArray *arr1 = [NSArray arrayWithObjects:@"a",@"b",@"c", nil];
    assertThat(arr1, hasItems(@"a",nil));    //包含一个对象
    assertThat(arr1, isNot(hasItems(@"X",nil)));  //不包含某一个对象
    assertThat(arr1, hasItems(equalToIgnoringCase(@"A"),nil));  //包含某一个对下岗，该对象忽略大小写后值为@“A”

    assertThat(arr1, contains(@"a",nil));   //包含某个对象
    assertThat(arr1, containsInAnyOrder(@"c",@"b",@"a",nil));   //包含某几个对象，并且乱序


    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"valA",@"keyA",@"valB",@"keyB",@"valueC",@"keyC", nil];
    assertThat(dic, hasCountOf(3));  //有3个key-value的组合
    assertThat(dic, isNot(isEmpty()));  //不为空
    assertThat(dic, hasKey(@"keyA"));   //有一个对象key值为@“keyA”；
    assertThat(dic, isNot(hasKey(@"keyX")));  //没有key值为“keyX”的对象
    assertThat(dic, hasValue(@"valueA"));     //有一个对象value值为"valueA";
    assertThat(dic, hasEntry(@"keyA", @"valA"));   //有一个对象key为“keyA”,并且value为“valueA”
    assertThat(dic, hasEntries(@"keyA",@"valA",@"keyB",@"valB",@"keyC",@"valC",nil));    //有多个对象，它们分别是。。。。

}
- (void)test1{
    

}

@end
