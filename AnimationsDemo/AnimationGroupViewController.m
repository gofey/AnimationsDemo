//
//  ViewController.m
//  CardMoveAnimation
//
//  Created by 厉国辉 on 17/2/20.
//  Copyright © 2017年 Xschool. All rights reserved.
//

#import "AnimationGroupViewController.h"
typedef NS_ENUM(NSInteger, FaceDirectionType) {
    FaceDirectionTypeLeftRight = 0,
    FaceDirectionTypeFrontBack = 1,
    FaceDirectionTypeUpDown = 2,
};
@interface AnimationGroupViewController ()
@property(strong,nonatomic)UIView *cardView;
@property(strong,nonatomic)UIImageView *cardImageView;
@property(copy,nonatomic)NSArray<UIColor *> *colorArray;

@end

@implementation AnimationGroupViewController
{
    CALayer *_rootLayer;
    NSInteger _index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _index = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.colorArray = @[[UIColor blueColor],[UIColor yellowColor],[UIColor redColor],[UIColor greenColor],[UIColor lightGrayColor],[UIColor orangeColor]];
    
    //创建主Layer
    
    _rootLayer = [CALayer layer];
    
    _rootLayer.contentsScale = [UIScreen mainScreen].scale;
    
//    _rootLayer.frame = self.view.bounds;
    
    UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2.0, 100, 100, 200)];
    [self.view addSubview:cardView];
    self.cardView = cardView;
    UIImageView * cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    [cardView addSubview:cardImageView];
    self.cardImageView = cardImageView;
//    cardImageView.image = [UIImage imageNamed:@"NSEa01"];
    //    [self startAnimation];//自己的动画
    _rootLayer.frame = self.cardImageView.bounds;
    [self.cardImageView.layer addSublayer:_rootLayer];
    //前
    
    [self addLayer:@[@0, @0, @5, @0, @0, @0, @0] forDirection:FaceDirectionTypeFrontBack];
    
    //后
    
    [self addLayer:@[@0, @0, @(-5), @(0), @0, @0, @0] forDirection:FaceDirectionTypeFrontBack];
    
    //左
    
    [self addLayer:@[@(-50), @0, @0, @(-M_PI_2), @0, @1, @0] forDirection:FaceDirectionTypeLeftRight];
    
    //右
    
    [self addLayer:@[@50, @0, @0, @(M_PI_2), @0, @1, @0] forDirection:FaceDirectionTypeLeftRight];
    
    //上
    
    [self addLayer:@[@0, @(-100), @0, @(-M_PI_2), @1, @0, @0] forDirection:FaceDirectionTypeUpDown];
    
    //下
    
    [self addLayer:@[@0, @100, @0, @(M_PI_2), @1, @0, @0] forDirection:FaceDirectionTypeUpDown];
    
    
    
    //主Layer的3D变换
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1.0 / 700;
    
    //在X轴上做一个20度的小旋转
    
    transform = CATransform3DRotate(transform, M_PI / 9, 1, 0, 0);
    
    //设置CALayer的sublayerTransform
    
    _rootLayer.sublayerTransform = transform;
    
    //添加Layer
    //开始动画
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:1];

    
//    [self.view.layer addSublayer:_rootLayer];
    
    
//    
//    
//    //动画
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"];
//    
//    //从0到360度
//    
//    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
//    
//    //间隔3秒
//    
//    animation.duration = 3.0;
//    
//    //无限循环
//    
//    animation.repeatCount = HUGE_VALF;
//    
//    //开始动画
//    
//    [_rootLayer addAnimation:animation forKey:@"rotation"];
//    
    
    
}
- (void)addLayer:(NSArray*)params forDirection:(FaceDirectionType)direction{
    
    //创建支持渐变背景的CAGradientLayer
    
    CALayer *gradient = [CALayer layer];
    
    //设置位置，和颜色等参数
    
    gradient.contentsScale = [UIScreen mainScreen].scale;
    
    
    if (direction == FaceDirectionTypeFrontBack) {
        gradient.bounds = CGRectMake(0, 0, 100, 200);
    }else if(direction == FaceDirectionTypeLeftRight){
        gradient.bounds = CGRectMake(0, 0, 10, 200);
    }else{
        gradient.bounds = CGRectMake(0, 0, 100, 10);
    }
    
    gradient.position = CGPointMake(CGRectGetMidX(self.cardImageView.bounds), CGRectGetMidY(self.cardImageView.bounds));
    gradient.backgroundColor = [self.colorArray[_index] CGColor];
    _index++;
    if (_index > 5) {
        _index = 0;
    }
    
    //根据参数对CALayer进行偏移和旋转Transform
    
    CATransform3D transform = CATransform3DMakeTranslation([[params objectAtIndex:0] floatValue], [[params objectAtIndex:1] floatValue], [[params objectAtIndex:2] floatValue]);
    
    transform = CATransform3DRotate(transform, [[params objectAtIndex:3] floatValue], [[params objectAtIndex:4] floatValue], [[params objectAtIndex:5] floatValue], [[params objectAtIndex:6] floatValue]);
    
    //设置transform属性并把Layer加入到主Layer中
    
    gradient.transform = transform;
    
    [_rootLayer addSublayer:gradient];
    
}
//- (void)addLayer:(NSArray*)params
//
//{
//    
//    //创建支持渐变背景的CAGradientLayer
//    
//    CALayer *gradient = [CALayer layer];
//    
//    //设置位置，和颜色等参数
//    
//    gradient.contentsScale = [UIScreen mainScreen].scale;
//    
//    gradient.bounds = CGRectMake(0, 0, 100, 100);
//    
//    gradient.position = CGPointMake(CGRectGetMidX(self.cardImageView.bounds), CGRectGetMidY(self.cardImageView.bounds));
//    gradient.backgroundColor = [self.colorArray[_index] CGColor];
//    _index++;
//    if (_index > 5) {
//        _index = 0;
//    }
//    
//    //根据参数对CALayer进行偏移和旋转Transform
//    
//    CATransform3D transform = CATransform3DMakeTranslation([[params objectAtIndex:0] floatValue], [[params objectAtIndex:1] floatValue], [[params objectAtIndex:2] floatValue]);
//    
//    transform = CATransform3DRotate(transform, [[params objectAtIndex:3] floatValue], [[params objectAtIndex:4] floatValue], [[params objectAtIndex:5] floatValue], [[params objectAtIndex:6] floatValue]);
//    
//    //设置transform属性并把Layer加入到主Layer中
//    
//    gradient.transform = transform;
//    
//    [_rootLayer addSublayer:gradient];
//    
//}
//

- (void)startAnimation{
    //第一步动画，由大变小兼绕y轴翻转，位移到左边
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"sublayerTransform"];
    CATransform3D transform3DFrom = CATransform3DMakeScale(2, 2, 1);
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(transform3DFrom, M_PI, 0, 1, 0)];
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation1.duration = 0.5;

    //第二步 y轴微浮动
    CAKeyframeAnimation *rotationAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"];
    
    rotationAnimation2.repeatCount = NSIntegerMax;
    rotationAnimation2.duration = 0.5;
    rotationAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation2.fillMode = kCAFillModeForwards;
    rotationAnimation2.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:- M_PI_2 * 0.3],@0,[NSNumber numberWithFloat:M_PI_2 * 0.3], nil];
    rotationAnimation2.autoreverses = YES;
    rotationAnimation2.fillMode = kCAFillModeForwards;
    rotationAnimation2.removedOnCompletion = NO;
    //第三步 位移 同时 翻转
    //翻转
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"sublayerTransform"];
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    animation3.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
    animation3.repeatCount = 2;
    animation3.duration = 0.25;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //位移
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:self.cardImageView.frame.origin];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.cardImageView.frame.origin.x - 80, self.cardImageView.frame.origin.y)];
    positionAnimation.duration = 0.5;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;

    
    //第四步 y轴微浮动
    CAKeyframeAnimation *rotationAnimation4 = [CAKeyframeAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"];
    
    rotationAnimation4.repeatCount = 3;
    rotationAnimation4.duration = 0.5;
    rotationAnimation4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation4.fillMode = kCAFillModeForwards;
    rotationAnimation4.removedOnCompletion = NO;
    rotationAnimation4.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:- M_PI_2 * 0.3],@0,[NSNumber numberWithFloat:M_PI_2 * 0.3], nil];
    rotationAnimation4.autoreverses = YES;
    
    //第五步 动画y轴翻转 放大
    CABasicAnimation *animation5 = [CABasicAnimation animationWithKeyPath:@"sublayerTransform"];
    CATransform3D transform3DFrom4 = CATransform3DMakeScale(2, 2, 1);
    animation5.removedOnCompletion = NO;
    animation5.fillMode = kCAFillModeForwards;
    animation5.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(transform3DFrom4, 0, 0, 1, 0)];
//    CATransform3D transform3DFromIdentity = CATransform3DMakeRotation(M_PI, 0, 1, 0);
//    transform3DFromIdentity = CATransform3DTranslate(transform3DFromIdentity, 80, 0, 0);
//    
//    animation5.fromValue = [NSValue valueWithCATransform3D:transform3DFromIdentity];
    animation5.duration = 0.5;
    animation5.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //第六步 消失动画
    CABasicAnimation *animaiton6 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animaiton6.toValue = [NSNumber numberWithFloat:0];
    animaiton6.duration = 0.5;
    animaiton6.fillMode = kCAFillModeForwards;
    animaiton6.removedOnCompletion = NO;
    animaiton6.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //动画组  组合
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:animation1,rotationAnimation2,animation3,positionAnimation,rotationAnimation4,animation5,animaiton6,nil];
    
    //    第一个动画执行时间
    animation1.beginTime = 0;
    //    第二个动画执行时间
    rotationAnimation2.beginTime = 0.5;
    //    第三个动画执行时间  位移翻转同时
    animation3.beginTime = 2;
    positionAnimation.beginTime = 2;
    //第四个动画时间
    rotationAnimation4.beginTime = 2.5;
    //第五个动画执行时间
    animation5.beginTime = 4;
    animaiton6.beginTime = 4;
    animationGroup.duration = 4.5;
    animationGroup.repeatCount = 0;
    
    
    [_rootLayer addAnimation:animationGroup forKey:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
