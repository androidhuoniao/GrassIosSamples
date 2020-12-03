//
//  SWSemaphoreDemo.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/12/3.
//

#import "SWSemaphoreDemo.h"

@implementation SWSemaphoreDemo
+ (void)start{
//    [[self class] testWithSerialQueue];
//    [[self class] test1];
//    [[self class] test2];
    [[self class] batchRequestConfig];
}

+(void) testWithSerialQueue{
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            NSLog(@"111:%@",[NSThread currentThread]);
        });
        dispatch_async(queue, ^{
            NSLog(@"222:%@",[NSThread currentThread]);
        });
        dispatch_async(queue, ^{
            NSLog(@"333:%@",[NSThread currentThread]);
        });
}

+(void) test1{
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"任务1:%@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:5];
            dispatch_semaphore_signal(sem);
        });
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"任务2:%@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:5];
            dispatch_semaphore_signal(sem);
        });
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"任务3:%@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:5];
        });
}

+(void) test2{
    [[self class] chainRequestCurrentConfig];
}
//链式请求，限制网络请求串行执行，第一个请求成功后再开始第二个请求
+ (void)chainRequestCurrentConfig {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *list = @[@"1",@"2",@"3"];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self fetchConfigurationWithCompletion:^(NSDictionary *dict) {
                NSLog(@"fetchConfigurationWithCompletion %@: ",list[idx]);
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }];
    });
}

+ (void)fetchConfigurationWithCompletion:(void(^)(NSDictionary *dict))completion {
    //AFNetworking或其他网络请求库
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //模拟网络请求
        sleep(2);
        !completion ? nil : completion(nil);
    });
}

+ (void)batchRequestConfig {
    dispatch_group_t group = dispatch_group_create();
    NSArray *list = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"enumerateObjectsUsingBlock: %@",list[idx]);
        //标记开始本次请求
        dispatch_group_enter(group);
        [self fetchConfigurationWithCompletion:^(NSDictionary *dict) {
            NSLog(@"fetchConfigurationWithCompletion %@: ",list[idx]);
            //标记本次请求完成
            dispatch_group_leave(group);
        }];
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //所有请求都完成了,执行刷新UI等操作
        NSLog(@"所有请求都完成了,执行刷新UI等操作");
    });
}

@end
