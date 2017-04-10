//
//  LoadingAnimationViewController.m
//  LittleDemos
//
//  Created by 厉国辉 on 2017/4/1.
//  Copyright © 2017年 Xschool. All rights reserved.
//

#import "LoadingAnimationViewController.h"
#import "LoadingView.h"
@interface LoadingAnimationViewController ()

@end

@implementation LoadingAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LoadingView *loading = [LoadingView addLoadingViewTo:self.view];
    self.view.backgroundColor = [UIColor blackColor];
    loading.ballColor = [UIColor blackColor];

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
