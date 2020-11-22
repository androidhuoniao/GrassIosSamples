//
//  QLAppLaunchTaskList.h
//  GrassIosSamples
//
//  Created by grass on 2020/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,TaskPropertyType){
    MAIN_SYNC1,
    MAIN_SYNC2,
    SUB_ASYNC1,
    SUB_ASYNC2
};

@interface QLAppLaunchTaskList : NSObject
/**
 工厂方法，返回一个指定类型的任务列表
 @param type 任务类型
 @return 任务列表
 */
+ (QLAppLaunchTaskList *)appLaunchTaskListWithType:(TaskPropertyType)type;

/**
 子类重写。批量执行任务分类下的所有任务
 */
- (void)runTasks;
@end

NS_ASSUME_NONNULL_END
