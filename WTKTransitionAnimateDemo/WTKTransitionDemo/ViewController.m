//
//  ViewController.m
//  WTKTransitionDemo
//
//  Created by 王同科 on 16/11/4.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "WTKTransition/WTKTransition.h"
#import "UIImage+ZHBImage.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *array;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(375, 64)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"AnimateTypeDefault",@"AnimateTypeDiffNavi",@"AnimateTypeKuGou",@"AnimateTypeRound",@"AnimationOval",@"AnimatrTypeDouYu"];
    UITableView *tableView  = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.rowHeight     = 60;
    tableView.delegate      = self;
    tableView.dataSource    = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationController.delegate = [WTKTransition shareManager];
    
   
    
}
                                          

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTKAnimateType type = indexPath.row == 0 ? WTKAnimateTypeDefault : indexPath.row == 1 ? WTKAnimateTypeDiffNavi : indexPath.row == 2 ? WTKAnimateTypeKuGou : indexPath.row == 3 ? WTKAnimateTypeRound : indexPath.row == 4 ? WTKAnimateTypeOval : WTKAnimateTypeDouYu;
    [WTKTransition shareManager].animationType = type;
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
