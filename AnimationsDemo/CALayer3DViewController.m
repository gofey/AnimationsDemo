//
//  CALayer3DViewController.m
//  LittleDemos
//
//  Created by 厉国辉 on 2017/4/1.
//  Copyright © 2017年 Xschool. All rights reserved.
//

#import "CALayer3DViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CALayer3DViewController ()
@property(strong,nonatomic)UIImageView *cardImageView;
@property(copy,nonatomic)NSArray<UIColor *> *colorArray;
@end

@implementation CALayer3DViewController{
    CALayer *_rootLayer;
    NSInteger _index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //得益于此博客，并非原创   http://www.itlead.com.cn/shownews.aspx?newid=20131127114816
    _index = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.colorArray = @[[UIColor blueColor],[UIColor yellowColor],[UIColor redColor],[UIColor greenColor],[UIColor lightGrayColor],[UIColor orangeColor]];
    
    //创建主Layer
    
    _rootLayer = [CALayer layer];
    
    _rootLayer.contentsScale = [UIScreen mainScreen].scale;
    UIImageView * cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 100) / 2.0, (ScreenHeight - 100) / 2, 100, 100)];
    [self.view addSubview:cardImageView];
    self.cardImageView = cardImageView;
    _rootLayer.frame = cardImageView.bounds;
    
    
    //前
    
    [self addLayer:@[@0, @0, @50, @0, @0, @0, @0]];
    
    //后
    
    [self addLayer:@[@0, @0, @(-50), @(0), @0, @0, @0]];
    
    //左
    
    [self addLayer:@[@(-50), @0, @0, @(-M_PI_2), @0, @1, @0]];
    
    //右
    
    [self addLayer:@[@50, @0, @0, @(M_PI_2), @0, @1, @0]];
    
    //上
    
    [self addLayer:@[@0, @(-50), @0, @(-M_PI_2), @1, @0, @0]];
    
    //下
    
    [self addLayer:@[@0, @50, @0, @(M_PI_2), @1, @0, @0]];
    
    
    
    //主Layer的3D变换
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1.0 / 700;
    
    //在X轴上做一个20度的小旋转
    
    transform = CATransform3DRotate(transform, M_PI / 9, 1, 0, 0);
    
    //设置CALayer的sublayerTransform
    
    _rootLayer.sublayerTransform = transform;
    
    //添加Layer
    [self.cardImageView.layer addSublayer:_rootLayer];
    
    //动画
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"];
    
    //从0到360度
    
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    //间隔3秒
    
    animation.duration = 3.0;
    
    //无限循环
    
    animation.repeatCount = HUGE_VALF;
    
    //开始动画
    
    [_rootLayer addAnimation:animation forKey:@"rotation"];
    

}
- (void)addLayer:(NSArray*)params

{
    
    //创建支持渐变背景的CAGradientLayer
    
    CALayer *gradient = [CALayer layer];
    
    //设置位置，和颜色等参数
    
    gradient.contentsScale = [UIScreen mainScreen].scale;
    
    gradient.bounds = CGRectMake(0, 0, 100, 100);
    
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
