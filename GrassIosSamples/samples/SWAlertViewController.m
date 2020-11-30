//
//  SWAlertViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/11/27.
//

#import "SWAlertViewController.h"

@interface SWAlertViewController ()
@property(nonnull,nonatomic,strong) UIButton *sysAlertBtn;
@property(nonnull,nonatomic,strong) UIButton *customAlert;

@end

@implementation SWAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sysAlertBtn = [self makeButton:@"系统alert" andTop:100];
    [_sysAlertBtn addTarget:self action:@selector(showAlertController1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sysAlertBtn];
//
//    CGFloat width = self.view.bounds.size.width;
//    _saveBtn = [[UIButton alloc]init];
//    _saveBtn.backgroundColor = UIColor.blueColor;
//    _saveBtn.frame = CGRectMake(0, 100, width, 100);
//    [_saveBtn setTitle:@"save" forState:UIControlStateNormal];
//    [_saveBtn addTarget:self action:@selector(onSaveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_saveBtn];
//
//    _loadBtn = [[UIButton alloc]init];
//    _loadBtn.backgroundColor = UIColor.blueColor;
//    CGFloat bottomSaveBtn = _saveBtn.frame.origin.y + _saveBtn.frame.size.height;
//    _loadBtn.frame = CGRectMake(0, bottomSaveBtn+20, width, 100);
//    [_loadBtn setTitle:@"load" forState:UIControlStateNormal];
//    [_loadBtn addTarget:self action:@selector(onLoadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_loadBtn];
//
//    _clearBtn = [[UIButton alloc]init];
//    _clearBtn.backgroundColor = UIColor.blueColor;
//    CGFloat bottomloadBtn = _loadBtn.frame.origin.y + _loadBtn.frame.size.height;
//    _clearBtn.frame = CGRectMake(0, bottomloadBtn+20, width, 100);
//    [_clearBtn setTitle:@"clear" forState:UIControlStateNormal];
//    [_clearBtn addTarget:self action:@selector(onClearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_clearBtn];
    
}


-(void) showAlertController1{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"message" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    // 展示弹框
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
