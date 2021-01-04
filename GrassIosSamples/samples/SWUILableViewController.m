//
//  SWUILableViewController.m
//  GrassIosSamples
//
//  Created by grassswwang(王圣伟) on 2020/12/28.
//

#import "SWUILableViewController.h"
#import <UIKit/UIKit.h>

@interface SWUILableViewController ()

@end

@implementation SWUILableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRichText2];
}

-(void) addHtmlUILable{
    
    NSString *htmlString = @"<html><body><img src=\"lable_icon\" /> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    myLabel.frame = CGRectMake(50,30, 350,80);
    myLabel.backgroundColor = UIColor.whiteColor;
    myLabel.attributedText = attrStr;
    [self.view addSubview:myLabel];
}


-(void) addRichText2{
    NSString *title = @"上边这样的顺序执行下来是先小图标在文本内容如上图一样，如果你图标想放在后面，就无需多拼接一次，直接用目标文本去拼接图标就可以";
    NSInteger fontsize = 20;
    /*备注：上边这样的顺序执行下来是先小图标在文本内容如上图一样，如果你图标想放在后面，就无需多拼接一次，直接用目标文本去拼接图标就可以，[completeText appendAttributedString:attachmentString];*/
    UILabel *myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    myLabel.frame = CGRectMake(5,200, 350,100);
    myLabel.backgroundColor = UIColor.whiteColor;
    myLabel.numberOfLines = 2;
    myLabel.font = [UIFont fontWithName:@"" size:fontsize];
    [self.view addSubview:myLabel];
    
    UIFont *font=[UIFont systemFontOfSize:fontsize];
    myLabel.font=font;
    
    //利用NSTextAttachment文UILabel添加图片，并调整位置实现居中对齐
    NSTextAttachment *attach=[[NSTextAttachment alloc] init];
    attach.bounds=CGRectMake(2, -4, 20, 20);
    NSString *imageName = @"lable_icon";
    attach.image = [UIImage imageNamed:imageName];
    
    NSMutableAttributedString *htmlString=[[NSMutableAttributedString alloc] init];
    NSAttributedString *imagePart=[NSAttributedString attributedStringWithAttachment:attach];
    [htmlString appendAttributedString:imagePart];
    
    NSDictionary *tagDict = @{ NSForegroundColorAttributeName: [UIColor redColor] };
    NSAttributedString *tagPart = [[NSAttributedString alloc] initWithString:@"限时特惠 " attributes:tagDict];
    [htmlString appendAttributedString:tagPart];
    
    NSAttributedString *titlePart = [[NSAttributedString alloc] initWithString:title];
    [htmlString appendAttributedString:titlePart];
    myLabel.attributedText=htmlString;
}


@end
