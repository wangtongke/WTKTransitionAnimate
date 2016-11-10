//
//  WTKTransition.h
//  WTKTransitionDemo
//
//  Created by 王同科 on 16/11/4.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///取消右滑返回发的通知
#define WTK_CANCEL_POP @"WTK_CANCEL_POP_NOTIFICATION"
typedef NS_ENUM(NSInteger,WTKAnimateType)
{
    WTKAnimateTypeDefault = 0,
    /// 两个导航栏不一致
    WTKAnimateTypeDiffNavi,
    ///仿酷狗
    WTKAnimateTypeKuGou,
    ///圆形遮罩
    WTKAnimateTypeRound,
    ///椭圆遮罩
    WTKAnimateTypeOval,
    ///仿斗鱼
    WTKAnimateTypeDouYu,
};

@interface WTKTransition : NSObject<UINavigationControllerDelegate>

///动画类型
@property(nonatomic,assign)WTKAnimateType animationType;

///是否显示阴影 (默认YES)
@property(nonatomic,assign)BOOL isShowShadow;

+ (instancetype)shareManager;

/**
 *  设置动画方式
 *  @param animationType 动画方式
 *  @param navi 导航
 */
- (void)setAnimationType:(WTKAnimateType)animationType
          withNavigation:(UINavigationController *)navi;

@end
