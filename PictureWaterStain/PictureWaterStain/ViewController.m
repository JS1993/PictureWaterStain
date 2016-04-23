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
    
    //创建一个带有圆环的头像
    [self setImage2];
    //截屏保存
    [self screenshout];
    
    
}

//截屏功能
-(void)screenshout{
    //创建位图上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    //取得当前上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //渲染当前屏幕的图层到上下本，注意：不能绘制，只能渲染
    [self.view.layer renderInContext:ctx];
    //获得当前上下文中渲染的图片
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    //创建一个data类型接收图片，格式为png也可以设置成Jpg并且jpg可以设置压缩质量0~1
    NSData* data= UIImagePNGRepresentation(image);
    //写入文件
    [data writeToFile:@"/Users/jiangsu/Desktop/截屏.png" atomically:YES];
    //关闭位图上下文
    UIGraphicsEndImageContext();
}
//圆形裁剪后有圆环
-(void)setImage2{
    
    UIImage* image=[UIImage imageNamed:@"IMG_2388 2"];
    
    CGFloat imageWH=MIN(image.size.width, image.size.height);
    //创建一个较大图形上下文
    CGFloat border=2;
    CGFloat ovalWH=imageWH+2*border;
    
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0.0);
    //绘制较大圆的路径
    UIBezierPath* ovalPath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0, ovalWH, ovalWH)];
    //填充红色
    [[UIColor redColor] set];
    [ovalPath fill];
    
    //设置圆形剪裁区域
    //创建圆形路径
    UIBezierPath* path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(border,border, imageWH, imageWH)];
    //把路径设置为剪裁区域
    [path addClip];
    
    //绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    
    //绘制字符串水印
    NSString* str=@"@jiangsu";
    
    //绘制字符串到当前上下文
    [str drawAtPoint:CGPointMake(image.size.width/2, image.size.height/2) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    //取得当前上下文中的图片
    UIImage* imagex=UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //创建显示图片的view
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50, imageWH,imageWH)];
    
    imageView.image=imagex;
    
    [self.view addSubview:imageView];
}
//圆形裁剪
-(void)setImage{
    
    UIImage* image=[UIImage imageNamed:@"IMG_2388 2"];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50, image.size.width, image.size.height)];
    //取得图片上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    //设置圆形剪裁区域
    //创建圆形路径
    UIBezierPath* path=[UIBezierPath bezierPathWithOvalInRect:imageView.bounds];
    //把路径设置为剪裁区域
    [path addClip];
    
    //绘制图片
    [image drawInRect:imageView.bounds];
    
    //绘制字符串水印
    NSString* str=@"@jiangsu";
    
    //绘制字符串到当前上下文
    [str drawAtPoint:CGPointMake(image.size.width/2, image.size.height/2) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    //取得当前上下文中的图片
    UIImage* imagex=UIGraphicsGetImageFromCurrentImageContext();
    
    imageView.image=imagex;
    
    [self.view addSubview:imageView];
    
    //关闭上下文
    UIGraphicsEndImageContext();
}

@end
