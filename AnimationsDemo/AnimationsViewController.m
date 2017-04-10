//
//  AnimationsViewController.m
//  LittleDemos
//
//  Created by 厉国辉 on 2017/4/1.
//  Copyright © 2017年 Xschool. All rights reserved.
//

#import "AnimationsViewController.h"
#import "OneViewController.h"
#import "AnimationGroupViewController.h"
#import "LoadingAnimationViewController.h"
#import "CALayer3DViewController.h"
#import "ImageTransitionViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface AnimationsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSArray *anitions;

@end

@implementation AnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _anitions = @[@"仿A GUIDE TO ANIMATION 转场动画mask ",@"动画组动画",@"Loading Animation",@"CALayer 3D",@"ImageTransition"];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth,  ScreenHeight - 20)];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.anitions[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.anitions.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[OneViewController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[AnimationGroupViewController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[LoadingAnimationViewController new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[CALayer3DViewController new] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[ImageTransitionViewController new] animated:YES];
            
            break;
        default:
            break;
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
