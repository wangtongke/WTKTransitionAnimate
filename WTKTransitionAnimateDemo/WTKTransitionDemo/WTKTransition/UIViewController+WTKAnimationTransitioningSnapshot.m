//
//  UIViewController+WTKAnimationTransitioningSnapshot.m
//  WTKPushAndPopAnimation
//
//  Created by 王同科 on 16/9/22.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "UIViewController+WTKAnimationTransitioningSnapshot.h"
#import "WTKTransition.h"
#import <objc/runtime.h>
#define w_kHeight [[UIScreen mainScreen] bounds].size.height
#define w_kWidth [[UIScreen mainScreen] bounds].size.width
@implementation UIViewController (WTKAnimationTransitioningSnapshot)
@dynamic interactivePopTransition;
+ (void)load
{
    Method originMethod     = class_getInstanceMethod(NSClassFromString(@"UIViewController"), @selector(viewDidLoad));
    Method newMethod        = class_getInstanceMethod(NSClassFromString(@"UIViewController"), @selector(wtk_viewDidLoad));
    method_exchangeImplementations(originMethod, newMethod);
}

- (void)wtk_viewDidLoad
{
    
    if (self.navigationController && self != self.navigationController.viewControllers.firstObject)
    {
        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePopRecognizer:)];
        [self.view addGestureRecognizer:popRecognizer];
    }
    [self wtk_viewDidLoad];
}

- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer
{
    static BOOL w_isDragging = NO;
    CGFloat progress = [recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));
    NSLog(@"progress---%.2f  w_isDragging--%d",progress,w_isDragging);
    NSLog(@"state = %ld",recognizer.state);
    NSLog(@"frame.x = %.2f",[recognizer translationInView:self.view].x);
    if (progress <= 0 && !w_isDragging && recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        w_isDragging = YES;
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        w_isDragging = YES;
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (progress > 0.25)
        {
            w_isDragging = NO;
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else
        {
            w_isDragging = NO;
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

- (UIPercentDrivenInteractiveTransition *)interactivePopTransition
{
    UIPercentDrivenInteractiveTransition *obj = objc_getAssociatedObject(self, @"WTKInteractivePopTransition");
    if (!obj)
    {
//        obj = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self setInteractivePopTransition:obj];
    }
    return obj;
}
- (void)setInteractivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition
{
    objc_setAssociatedObject(self, @"WTKInteractivePopTransition", interactivePopTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)snapshot
{
    UIView *view = objc_getAssociatedObject(self, @"WTKAnimationTransitioningSnapshot");
    if (!view)
    {
        view = self.tabBarController ? [self.tabBarController.view snapshotViewAfterScreenUpdates:NO] : [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
        [self setSnapshot:view];
    }
    return view;
}

- (void)setSnapshot:(UIView *)snapshot
{
    objc_setAssociatedObject(self, @"WTKAnimationTransitioningSnapshot", snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView *)topSnapshot
{
    UIView *view = objc_getAssociatedObject(self, @"WTKAnimationTransitioningTopSnapshot");
    if(!view)
    {
        view = [self.navigationController.view resizableSnapshotViewFromRect:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 64) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        
        [self setTopSnapshot:view];
    }
    return view;
}
- (void)setTopSnapshot:(UIView *)topSnapshot
{
    objc_setAssociatedObject(self, @"WTKAnimationTransitioningTopSnapshot", topSnapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView *)viewSnapshot
{
    UIView *view = objc_getAssociatedObject(self, @"WTKAnimationTransitioningViewSnapshot");
    if (!view)
    {
        view = [self.navigationController.view resizableSnapshotViewFromRect:CGRectMake(0, 64, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 64) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        [self setViewSnapshot:view];
    }
    return view;
}
- (void)setViewSnapshot:(UIView *)viewSnapshot
{
    objc_setAssociatedObject(self, @"WTKAnimationTransitioningViewSnapshot", viewSnapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

@end
