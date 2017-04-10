//
//  SecondViewController.m
//  转场封装测试1
//
//  Created by lijie on 16/10/10.
//  Copyright © 2016年 lijie. All rights reserved.
//

#import "SecondViewController.h"
#import "PingInvertTransition.h"
@interface SecondViewController ()<UINavigationControllerDelegate>

@end

@implementation SecondViewController
{
    
    UIPercentDrivenInteractiveTransition *percentTransition;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];
    backBtn.frame = CGRectMake(15, 64, 60, 60);
    backBtn.backgroundColor = [UIColor blueColor];
    [backBtn addTarget:self action:@selector(preController) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //加手势--左边侧滑返回
    UIScreenEdgePanGestureRecognizer *panGes = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(leftEdgePan:)];
    panGes.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:panGes];
    
    
    
    
}
- (void)leftEdgePan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGFloat per = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    per = MIN(1.0,(MAX(0.0, per)));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [percentTransition updateInteractiveTransition:per];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (per > 0.3) {
            [percentTransition finishInteractiveTransition];
        }else{
            [percentTransition cancelInteractiveTransition];
        }
        percentTransition = nil;
    }

}
- (void) preController{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- UINavigationDelegate
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return percentTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        return [[PingInvertTransition alloc] init];
    }
    else{
        return nil;
    }
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
