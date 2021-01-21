//
//  SWUIPageControlViewController.m
//  GrassIosSamples
//
//  Created by 王圣伟 on 2021/1/21.
//

#import "SWUIPageControlViewController.h"

@interface SWUIPageControlViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *helpScrView;
@property (nonatomic,strong) UIPageControl *pageCtrl;
@end

@implementation SWUIPageControlViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    CGRect bounds = self.view.frame;
    
    //加载蒙板图片，限于篇幅，这里仅显示一张图片的加载方法
    UIImageView* imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];  //创建UIImageView，位置大小与主界面一样。
    
    imageView1.backgroundColor = [UIColor brownColor];
    
    //imageView1.alpha = 0.5f;  //将透明度设为50%。
    
    UIImageView* imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];  //创建UIImageView，位置大小与主界面一样。
    
    imageView2.backgroundColor = [UIColor cyanColor];
    
    //创建UIScrollView，位置大小与主界面一样。
    self.helpScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 300)];
    //设置全部内容的尺寸，这里帮助图片是3张，所以宽度设为界面宽度*3，高度和界面一致。
    [self.helpScrView setContentSize:CGSizeMake(bounds.size.width * 6, 300)];
    
    self.helpScrView.pagingEnabled = YES;  //设为YES时，会按页滑动
    
    self.helpScrView.bounces = YES; //取消UIScrollView的弹性属性，这个可以按个人喜好来定
    
    [self.helpScrView setDelegate:self];//UIScrollView的delegate函数在本类中定义
    
    self.helpScrView.showsHorizontalScrollIndicator = NO;  //因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
    
    [self.helpScrView addSubview:imageView2];
    
    [self.helpScrView addSubview:imageView1];
    
    self.helpScrView.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:self.helpScrView];
    
    //创建UIPageControl，位置在屏幕最下方。
    self.pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, bounds.size.width, 30)];
    self.pageCtrl.numberOfPages = 2;//总的图片页数
    self.pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageCtrl.pageIndicatorTintColor = [UIColor orangeColor];
    self.pageCtrl.currentPage = 0; //当前页
    //用户点击UIPageControl的响应函数
    [self.pageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageCtrl];  //将UIPageControl添加到主界面上。
    
}

//其次是UIScrollViewDelegate的scrollViewDidEndDecelerating函数，用户滑动页面停下后调用该函数。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageCtrl setCurrentPage:offset.x / bounds.size.width];
    NSLog(@"%f",offset.x / bounds.size.width);
}

//然后是点击UIPageControl时的响应函数pageTurn
- (void)pageTurn:(UIPageControl*)sender{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.helpScrView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.helpScrView scrollRectToVisible:rect animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end

