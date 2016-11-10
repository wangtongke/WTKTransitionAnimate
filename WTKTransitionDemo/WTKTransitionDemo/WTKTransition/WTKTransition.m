//
//  WTKTransition.m
//  WTKTransitionDemo
//
//  Created by 王同科 on 16/11/4.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "WTKTransition.h"
#import "WTKBaseAnimation.h"
#import "UIViewController+WTKAnimationTransitioningSnapshot.h"



@interface WTKTransition ()

@end

@implementation WTKTransition
+ (instancetype)shareManager
{
    static WTKTransition *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WTKTransition alloc]init];
        manager.isShowShadow = YES;
    });
    return manager;
}

- (void)setAnimationType:(WTKAnimateType)animationType withNavigation:(UINavigationController *)navi
{
    self.animationType = animationType;
    if (animationType == WTKAnimateTypeDefault)
    {
        navi.delegate = nil;
    }
}
- (void)setAnimationType:(WTKAnimateType)animationType
{
    if (animationType == WTKAnimateTypeDefault)
    {
        _animationType = WTKAnimateTypeDiffNavi;
    }
    else
    {
        _animationType = animationType;
    }
}

//- (WTKAnimateType)animationType
//{
//    if ([WTKTransition shareManager].animationType == WTKAnimateTypeDefault)
//    {
//        return WTKAnimateTypeDiffNavi;
//    }
//    return [WTKTransition shareManager].animationType;
//}

#pragma mark - UINavigationDelegate
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(WTKBaseAnimation*) animationControlle
{
    return animationControlle.interactivePopTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    //    WTKBaseAnimation *animation = [[WTKBaseAnimation alloc]init];
    if (fromVC.interactivePopTransition)
    {
        WTKBaseAnimation *animation = [[WTKBaseAnimation alloc]initWithType:operation Duration:0.6 animateType:self.animationType];
        animation.interactivePopTransition = fromVC.interactivePopTransition;
        return animation; //手势
    }
    else
    {
        WTKBaseAnimation *animation = [[WTKBaseAnimation alloc]initWithType:operation Duration:0.6 animateType:self.animationType];
        return animation;//非手势
    }
  
}
@end
