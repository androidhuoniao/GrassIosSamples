//
//  HelloJsonViewController.m
//  GrassIosSamples
//  Json解析的各种测试用例
//  NSDictionary的keypath用法真是牛逼
//  [NSDictionary \| Apple Developer Documentation](https://developer.apple.com/documentation/foundation/nsdictionary?language=objc)
//  Created by grassswwang(王圣伟) on 2020/11/18.
//

#import "HelloJsonViewController.h"

@interface HelloJsonViewController ()

@end

@implementation HelloJsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSString *jsonStr = [self obj2Json];
    NSDictionary *dict = [self json2Obj:jsonStr];
    NSLog(@"--------------dict----------\n:%@",dict);
    NSString *carname = [dict valueForKeyPath:@"car.carname"];
    NSLog(@"carname=%@",carname);
}

-(NSDictionary *) json2Obj:(NSString*) jsonStr{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
    }else{
        NSLog(@"json解析成功：%@",dic);
    }
    return dic;
}

-(NSString*) obj2Json{

    NSDictionary *cardict = @{@"carname":@"audi",@"price":@100000};
        
    NSMutableDictionary *personDict = [NSMutableDictionary dictionary];
    [personDict setValue:@"grass" forKey:@"name"];
    [personDict setValue:@32 forKey:@"age"];
    [personDict setValue:cardict forKey:@"car"];
    NSLog(@"personDict:%@",personDict);
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:personDict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString %@", jsonString);
    return jsonString;
}
@end
