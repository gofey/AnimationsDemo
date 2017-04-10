//
//  ViewController.m
//  转场封装测试1
//
//  Created by lijie on 16/10/10.
//  Copyright © 2016年 lijie. All rights reserved.
//

#import "OneViewController.h"
#import "SecondViewController.h"
#import "PingTransition.h"
@interface OneViewController ()<UINavigationControllerDelegate>

@end

@implementation OneViewController
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.delegate = self;
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:goBtn];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
    goBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 75, 64, 60, 60);
    goBtn.backgroundColor = [UIColor blackColor];
    self.button = goBtn;
    [goBtn addTarget:self action:@selector(goNextController) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) goNextController{
    [self.navigationController pushViewController:[[SecondViewController  alloc] init] animated:YES];
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    
    
    if (operation == UINavigationControllerOperationPush) {
        
        
        return [[PingTransition alloc] init];
    }else{
        
        
        
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
