//
//  DetailViewController.m
//  WTKTransitionDemo
//
//  Created by 王同科 on 16/11/4.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "DetailViewController.h"
#import "WTKTransition/WTKTransition.h"
#import "UIImage+ZHBImage.h"
@interface DetailViewController ()

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
       [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"222"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"第二页";
    NSLog(@"detail");
//    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame=  CGRectMake(0, 0, 30, 30);
//    btn.backgroundColor = [UIColor redColor];
//    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    WTKTransition *tran = [[WTKTransition alloc]init];
//    self.navigationController.delegate = tran;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"backbutton_icon3"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetNavi) name:WTK_CANCEL_POP object:nil];
    

}

- (void)resetNavi
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"222"] forBarMetrics:UIBarMetricsDefault];
    NSLog(@"%d",self.navigationController.navigationBar.hidden);
}
- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    NSLog(@"shifang");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
