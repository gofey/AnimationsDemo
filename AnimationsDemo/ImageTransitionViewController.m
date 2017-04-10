//
//  ImageTransitionViewController.m
//  AnimationsDemo
//
//  Created by 厉国辉 on 2017/4/1.
//  Copyright © 2017年 Xschool. All rights reserved.
//

#import "ImageTransitionViewController.h"

@interface ImageTransitionViewController ()

@property(assign,nonatomic)int index;
@property(strong,nonatomic)UIImageView *iconImageView;
@end

@implementation ImageTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.index = 1;
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2.0, 100, 100, 100)];
    [self.view addSubview:iconImageView];
    self.iconImageView = iconImageView;
    iconImageView.image = [UIImage imageNamed:@"NSEa01"];
    UIButton *preButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:preButton];
    preButton.layer.cornerRadius = 5;
    preButton.layer.masksToBounds = YES;
    preButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 70) / 2.0, CGRectGetMaxY(iconImageView.frame) + 15, 70, 30);
    [preButton setTitle:@"上一个" forState:UIControlStateNormal];
    preButton.backgroundColor = [UIColor blackColor];
    [preButton addTarget:self action:@selector(preBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:nextButton];
    nextButton.layer.cornerRadius = 5;
    nextButton.layer.masksToBounds = YES;
    nextButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 70) / 2.0, CGRectGetMaxY(preButton.frame)  + 15, 70, 30);
    [nextButton setTitle:@"下一个" forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor blackColor];
    [nextButton addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)preBtnClick:(UIButton *)sender{
    self.index--;
    if (self.index<1) {
        self.index=7;
    }
    self.iconImageView.image=[UIImage imageNamed: [NSString stringWithFormat:@"NSEa0%d",self.index]];
    
    //创建核心动画
    CATransition *ca=[CATransition animation];
    //告诉要执行什么动画
    //设置过度效果
    ca.type=@"cube";
    //设置动画的过度方向（向左）
    ca.subtype=kCATransitionFromLeft;
    //设置动画的时间
    ca.duration=2.0;
    //添加动画
    [self.iconImageView.layer addAnimation:ca forKey:nil];
}

- (void)nextBtnClick:(UIButton *)sender{
    self.index++;
    if (self.index>7) {
        self.index=1;
    }
    self.iconImageView.image=[UIImage imageNamed: [NSString stringWithFormat:@"NSEa0%d",self.index]];
    
    //1.创建核心动画
    CATransition *ca=[CATransition animation];
    
    //1.1告诉要执行什么动画
    //1.2设置过度效果
    ca.type=@"cube";
    //1.3设置动画的过度方向（向右）
    ca.subtype=kCATransitionFromRight;
    //1.4设置动画的时间
    ca.duration=2.0;
    //1.5设置动画的起点
    //    ca.startProgress=0.5;
    //1.6设置动画的终点
    //    ca.endProgress=0.5;
    
    //2.添加动画
    [self.iconImageView.layer addAnimation:ca forKey:nil];
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
