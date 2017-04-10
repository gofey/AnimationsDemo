//
//  LoadingView.m
//  ThreeBallsAnimation
//
//  Created by 厉国辉 on 16/12/21.
//  Copyright © 2016年 Xschool. All rights reserved.
//

#import "LoadingView.h"
#define WIDTH       200
#define HEIGHT      150
#define CENTER_X    self.frame.size.width / 2
#define CENTER_Y    self.frame.size.height / 2

#define BALL_RADIUS 20

@interface LoadingView()<CAAnimationDelegate>{
    UIColor *_ballColor;
}

/**第1个球 */
@property (nonatomic, strong) UIView *ball_1;
/**第2个球 */
@property (nonatomic, strong) UIView *ball_2;
/**第3个球 */
@property (nonatomic, strong) UIView *ball_3;

@end

@implementation LoadingView
+ (instancetype)addLoadingViewTo:(UIView *)addView{
    return [[self alloc] addLoadingViewTo:addView];
}
- (instancetype)addLoadingViewTo:(UIView *)addView{
    LoadingView *loadView = [self initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - WIDTH / 2, [UIScreen mainScreen].bounds.size.height / 2 - HEIGHT / 2 , WIDTH, HEIGHT)];
    [addView addSubview:loadView];
    return loadView;

}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIVisualEffectView *bgView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        bgView.alpha = 0.9f;
        bgView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        bgView.layer.cornerRadius = BALL_RADIUS / 2;
        bgView.clipsToBounds = YES;
        [self addSubview:bgView];
        [self initSubViews];
    }
    return self;
}

- (UIColor *)ballColor{
    if (_ballColor) {
        return _ballColor;
    }
    return [UIColor blackColor];
}

- (void)setBallColor:(UIColor *)ballColor{
    _ballColor = ballColor;
    self.ball_1.backgroundColor = ballColor;
    
    self.ball_2.backgroundColor = ballColor;
    
    self.ball_3.backgroundColor = ballColor;
}

- (void)initSubViews{
//    NSLog(@"ok");
    //对三个球初始化
    UIView *ball_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BALL_RADIUS, BALL_RADIUS)];
    [self addSubview:ball_1];
    self.ball_1 = ball_1;
    ball_1.center = CGPointMake(CENTER_X - BALL_RADIUS, CENTER_Y);
    ball_1.backgroundColor = self.ballColor;
    ball_1.layer.cornerRadius = BALL_RADIUS / 2;
    ball_1.layer.masksToBounds = YES;
    
    UIView *ball_2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BALL_RADIUS, BALL_RADIUS)];
    [self addSubview:ball_2];
    self.ball_2 = ball_2;
    ball_2.center = CGPointMake(CENTER_X, CENTER_Y);
    ball_2.backgroundColor = self.ballColor;
    ball_2.layer.cornerRadius = BALL_RADIUS / 2;
    ball_2.layer.masksToBounds = YES;
    
    UIView *ball_3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BALL_RADIUS, BALL_RADIUS)];
    [self addSubview:ball_3];
    self.ball_3 = ball_3;
    ball_3.center = CGPointMake(CENTER_X + BALL_RADIUS, CENTER_Y);
    ball_3.backgroundColor = self.ballColor;
    ball_3.layer.cornerRadius = BALL_RADIUS / 2;
    ball_3.layer.masksToBounds = YES;
    
    
    [self startAnimation];
}
- (void)startAnimation{
    //设定每个球的旋转路径
    UIBezierPath *ball_1_path = [UIBezierPath bezierPath];
//    [ball_1_path moveToPoint:self.ball_1.center];
    [ball_1_path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(CENTER_X, CENTER_Y) radius:BALL_RADIUS startAngle:M_PI endAngle:M_PI * 2 clockwise:NO]];
    [ball_1_path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(CENTER_X, CENTER_Y) radius:BALL_RADIUS startAngle:0 endAngle:M_PI clockwise:NO]];
    CAKeyframeAnimation *ball_1_moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ball_1_moveAnimation.path = ball_1_path.CGPath;
    ball_1_moveAnimation.duration = 1.4;
    ball_1_moveAnimation.delegate = self;
    ball_1_moveAnimation.removedOnCompletion = NO;
    ball_1_moveAnimation.fillMode = kCAFillModeForwards;
    ball_1_moveAnimation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    ball_1_moveAnimation.calculationMode = kCAAnimationCubic;
    [self.ball_1.layer addAnimation:ball_1_moveAnimation forKey:nil];
    
    UIBezierPath *ball_3_path = [UIBezierPath bezierPath];

    [ball_3_path addArcWithCenter:CGPointMake(CENTER_X, CENTER_Y) radius:BALL_RADIUS startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    
    CAKeyframeAnimation *ball_3_moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    ball_3_moveAnimation.path = ball_3_path.CGPath;
    ball_3_moveAnimation.duration = 1.4;
    ball_3_moveAnimation.removedOnCompletion = NO;
    ball_3_moveAnimation.calculationMode = kCAAnimationCubic;
    ball_3_moveAnimation.fillMode = kCAFillModeForwards;
    ball_3_moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.ball_3.layer addAnimation:ball_3_moveAnimation forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self startAnimation];
    }
}
- (void)animationDidStart:(CAAnimation *)anim{
    //在旋转的同时，为球1  球3设定水平位移动画   大小变化动画
    [UIView animateWithDuration:0.3 delay:-0.2 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.ball_1.transform = CGAffineTransformMakeTranslation(-BALL_RADIUS, 0);
        self.ball_1.transform = CGAffineTransformScale(self.ball_1.transform, 0.7, 0.7);
        
        self.ball_3.transform = CGAffineTransformMakeTranslation(BALL_RADIUS, 0);
        self.ball_3.transform = CGAffineTransformScale(self.ball_3.transform, 0.7, 0.7);
        
        self.ball_2.transform = CGAffineTransformScale(self.ball_2.transform, 0.7, 0.7);
    } completion:^(BOOL finished) {
        //动画结束后恢复到初始状态
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.ball_1.transform = CGAffineTransformIdentity;
            self.ball_3.transform = CGAffineTransformIdentity;
            self.ball_2.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
