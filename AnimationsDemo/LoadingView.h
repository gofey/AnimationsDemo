//
//  LoadingView.h
//  ThreeBallsAnimation
//
//  Created by 厉国辉 on 16/12/21.
//  Copyright © 2016年 Xschool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

/** 球的颜色 */
@property (nonatomic,strong) UIColor *ballColor;

/** 展示加载动画*/
+ (instancetype)addLoadingViewTo:(UIView *)addView;

- (instancetype)addLoadingViewTo:(UIView *)addView;
/**
 *  关闭加载动画
 */

@end
