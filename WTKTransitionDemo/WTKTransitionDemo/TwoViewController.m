//
//  TwoViewController.m
//  WTKTransitionDemo
//
//  Created by 王同科 on 16/11/4.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor greenColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(50, 70, 200, 80)];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"截图" forState:UIControlStateNormal];
    btn.frame = CGRectMake(80, 400, 100, 40);
    btn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

    

    
}
- (void)btnClick
{
    UIImage *image = [self imageFromView:self.tabBarController.view];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 70, 375, 300);
    [self.view addSubview:imageView];
    
//    UIView *view = [self.view snapshotViewAfterScreenUpdates:YES];
//    view.frame = CGRectMake(0, 70, 375, 300);
    [self.view addSubview:imageView];
}
///获取截图
- (UIImage *)imageFromView:(UIView *)snapView {
    UIGraphicsBeginImageContext(snapView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [snapView.layer renderInContext:context];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
