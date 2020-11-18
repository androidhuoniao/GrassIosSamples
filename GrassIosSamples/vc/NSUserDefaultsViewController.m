//
//  NSUserDefaultsViewController.m
//  GrassIosSamples
//  用来添加NSUserDefaults的各种用例
//  Created by grassswwang(王圣伟) on 2020/11/18.
//

#import "NSUserDefaultsViewController.h"

@interface NSUserDefaultsViewController ()
@property(nonnull,nonatomic,strong) NSMutableDictionary<NSString *,id> *defaultData;
@property(nonnull,nonatomic,strong) UIButton *saveBtn;
@property(nonnull,nonatomic,strong) UIButton *loadBtn;
@property(nonnull,nonatomic,strong) UIButton *clearBtn;
@end

@implementation NSUserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *nsDefaults = [NSUserDefaults standardUserDefaults];
    [nsDefaults registerDefaults:self.defaultData];
    CGFloat width = self.view.bounds.size.width;
    _saveBtn = [[UIButton alloc]init];
    _saveBtn.backgroundColor = UIColor.blueColor;
    _saveBtn.frame = CGRectMake(0, 100, width, 100);
    [_saveBtn setTitle:@"save" forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(onSaveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    
    _loadBtn = [[UIButton alloc]init];
    _loadBtn.backgroundColor = UIColor.blueColor;
    CGFloat bottomSaveBtn = _saveBtn.frame.origin.y + _saveBtn.frame.size.height;
    _loadBtn.frame = CGRectMake(0, bottomSaveBtn+20, width, 100);
    [_loadBtn setTitle:@"load" forState:UIControlStateNormal];
    [_loadBtn addTarget:self action:@selector(onLoadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadBtn];
    
    _clearBtn = [[UIButton alloc]init];
    _clearBtn.backgroundColor = UIColor.blueColor;
    CGFloat bottomloadBtn = _loadBtn.frame.origin.y + _loadBtn.frame.size.height;
    _clearBtn.frame = CGRectMake(0, bottomloadBtn+20, width, 100);
    [_clearBtn setTitle:@"clear" forState:UIControlStateNormal];
    [_clearBtn addTarget:self action:@selector(onClearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clearBtn];
    
}

-(void) onSaveBtnClick:(UIButton *) button{
    NSLog(@"onSaveBtnClick is working");
    [self savePref];
}

-(void) onLoadBtnClick:(UIButton *) button{
    NSLog(@"onLoadBtnClick is working");
    [self loadPref];
}

-(void) onClearBtnClick:(UIButton *) button{
    NSLog(@"onClearBtnClick is working");
    [self clearPref];
}


- (void)savePref{
    NSUserDefaults *nsDefaults = [NSUserDefaults standardUserDefaults];
    [nsDefaults setObject:@"grass" forKey:@"name"];
    [nsDefaults setInteger:32 forKey:@"age"];
    [nsDefaults synchronize];
}

- (void)loadPref{
    NSUserDefaults *nsDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [nsDefaults objectForKey:@"name"];
    NSInteger age = [nsDefaults integerForKey:@"age"];
    NSLog(@"%@-------%ld",name,age);
}

/**
 这个函数经过测试没有问题，appDominStr的取值为grass.GrassIosSamples
 */
- (void)clearPref{
    NSString *appDomainStr = [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"%s appDominStr:%@",__func__,appDomainStr);
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomainStr];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 这个函数经过测试没有问题，
 */
- (void)clearPref2{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSDictionary* dict = [defs dictionaryRepresentation];
    for(id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

- (NSDictionary<NSString *,id> *)defaultData{
    if (!_defaultData) {
        _defaultData = [NSMutableDictionary dictionary];
        [_defaultData setObject:@"grass1111" forKey:@"name"];
        [_defaultData setObject:[NSNumber numberWithInt:34] forKey:@"age"];
    }
    return _defaultData;
}


@end
