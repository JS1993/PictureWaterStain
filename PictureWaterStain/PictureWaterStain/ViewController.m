//
//  ViewController.m
//  PictureWaterStain
//
//  Created by  江苏 on 16/4/22.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage* image=[UIImage imageNamed:@"IMG_2388 2"];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50, image.size.width, image.size.height)];
    //取得图片上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    //绘制图片
    [image drawInRect:imageView.bounds];
    
    //绘制字符串水印
    NSString* str=@"@jiangsu";
    
    //绘制字符串到当前上下文
    [str drawAtPoint:CGPointMake(image.size.width-60, image.size.height-30) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    
    
    //取得当前上下文中的图片
    UIImage* imagex=UIGraphicsGetImageFromCurrentImageContext();
    
    imageView.image=imagex;
    
    [self.view addSubview:imageView];
    
    //关闭上下文
    UIGraphicsEndPDFContext();
    
}


@end
