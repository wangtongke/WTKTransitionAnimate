//
//  UIImage+ZHBImage.m
//  ZHB
//
//  Created by Lrc on 15/6/4.
//  Copyright (c) 2015年 何霄云. All rights reserved.
//

#import "UIImage+ZHBImage.h"

@implementation UIImage (ZHBImage)

#pragma mark 根据颜色和size生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
