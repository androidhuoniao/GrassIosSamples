//
//  SWGcdViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/27.
//

#import "SWGcdViewController.h"
#import "SWSemaphoreDemo.h"

@interface SWGcdViewController ()

@end

@implementation SWGcdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SWSemaphoreDemo start];
////    [self logThread];
////    [self execSync];
////    [self execAsync];
//    [self subThread2MainThread];
//    [self tryDispatchAfater];
    
}

- (void)logThread{
    NSLog(@"logThread \n currentThread:%@, mainThread:%@,isMainThread:%i",NSThread.currentThread,NSThread.mainThread,NSThread.isMainThread);
}

- (void) execSync{
//    [self syncParallelQueue];
//    [self syncMainQueue];
    [self syncSerialQueue];
}

- (void) syncParallelQueue{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *methodName = [NSString stringWithFormat:@"%s",__func__];
    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task1 i=%i",methodName,i);
        }
        NSLog(@"%@ task1 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task2 i=%i",methodName,i);
        }
        NSLog(@"%@ task2 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task3 i=%i",methodName,i);
        }
        NSLog(@"%@ task3 %@",methodName,NSThread.currentThread);
    });
}

/**
 这种情况会出现死锁
 sync和main queue的组合,首先主线程的队列肯定就是main queue,
 如下的代码相当于在主线程里,自己扔了一个block到自己的queue的末尾,dispach_sync函数
 等着block执行完毕,block同时也等着dispatch_sync函数执行完毕
 */
-(void) syncMainQueue{
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSString *methodName = [NSString stringWithFormat:@"%s",__func__];
    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task1 i=%i",methodName,i);
        }
        NSLog(@"%@ task1 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task2 i=%i",methodName,i);
        }
        NSLog(@"%@ task2 %@",methodName,NSThread.currentThread);
    });

    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task3 i=%i",methodName,i);
        }
        NSLog(@"%@ task3 %@",methodName,NSThread.currentThread);
    });
}

-(void) syncSerialQueue{
    dispatch_queue_t queue = dispatch_queue_create("Serial", NULL);
    NSString *methodName = [NSString stringWithFormat:@"%s",__func__];
    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task1 i=%i",methodName,i);
        }
        NSLog(@"%@ task1 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task2 i=%i",methodName,i);
        }
        NSLog(@"%@ task2 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task3 i=%i",methodName,i);
        }
        NSLog(@"%@ task3 %@",methodName,NSThread.currentThread);
    });
    
}

//------------------------------
- (void) execAsync{
//    [self asyncMainQueue];
//    [self asyncSerialQueue];
    [self asyncParallelQueue];
}

- (void) asyncParallelQueue{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *methodName = [NSString stringWithFormat:@"%s",__func__];
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task1 i=%i",methodName,i);
        }
        NSLog(@"%@ task1 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task2 i=%i",methodName,i);
        }
        NSLog(@"%@ task2 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task3 i=%i",methodName,i);
        }
        NSLog(@"%@ task3 %@",methodName,NSThread.currentThread);
    });
}

-(void) asyncMainQueue{
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSString *methodName = [NSString stringWithFormat:@"%s",__func__];
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task1 i=%i",methodName,i);
        }
        NSLog(@"%@ task1 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task2 i=%i",methodName,i);
        }
        NSLog(@"%@ task2 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task3 i=%i",methodName,i);
        }
        NSLog(@"%@ task3 %@",methodName, NSThread.currentThread);
    });
}

-(void) asyncSerialQueue{
    dispatch_queue_t queue = dispatch_queue_create("Serial", NULL);
    NSString *methodName = [NSString stringWithFormat:@"%s",__func__];
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task1 i=%i",methodName,i);
        }
        NSLog(@"%@ task1 %@",methodName, NSThread.currentThread);
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task2 i=%i",methodName,i);
        }
        NSLog(@"%@ task2 %@",methodName,NSThread.currentThread);
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"%@ task3 i=%i",methodName,i);
        }
        NSLog(@"%@ task3 %@",methodName,NSThread.currentThread);
    });
    
}

/**
 从子线程切换到主线程
 */
-(void) subThread2MainThread{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"subThread2MainThread %@",NSThread.currentThread);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"subThread2MainThread.dispatch_get_main_queue: %@",NSThread.currentThread);
        });
    });
}

-(void) tryDispatchAfater{
    NSLog(@"tryDispatchAfater is working");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"tryDispatchAfater thread:%@",NSThread.currentThread);
    });
}

@end
