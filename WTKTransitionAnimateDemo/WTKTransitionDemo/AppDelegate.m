//
//  AppDelegate.m
//  WTKTransitionDemo
//
//  Created by 王同科 on 16/11/4.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TwoViewController.h"
#import "WTKTransition/WTKTransition.h"

@interface AppDelegate ()
@property(nonatomic,strong)WTKTransition *tran;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *home = [[ViewController alloc]init];
    UINavigationController *navi1 = [self setChildVC:home title:@"首页" imageName:@"" withSelectedName:@""];
    
    TwoViewController *two = [[TwoViewController alloc]init];
    UINavigationController *navi2 = [self setChildVC:two title:@"二二" imageName:@"" withSelectedName:@""];
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    tab.viewControllers = @[navi1,navi2];
    
    [[UIApplication sharedApplication].delegate window].rootViewController = tab;
    
    return YES;
}

- (UINavigationController *)setChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imgName withSelectedName:(NSString *)selectedName
{
    vc.title                = title;
    vc.tabBarItem.image     = [UIImage imageNamed:imgName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedName];
    
    vc.tabBarController.tabBar.tintColor   = [UIColor whiteColor];
    
    NSDictionary *dic       = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:12]};
    [vc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    NSDictionary *selectDic = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12]};
    [vc.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    return nav;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
