//
//  DIYTabbarController.m
//  First
//
//  Created by 陈双林 on 16/12/3.
//  Copyright © 2016年 陈双林. All rights reserved.
//

#import "DIYTabbarController.h"
#import "MainViewController.h"
#import "CategoryViewController.h"
#import "MyViewController.h"
#import "DownloadViewController.h"

@interface DIYTabbarController ()

@end

@implementation DIYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建主界面（精选）
    MainViewController * mainVC = [MainViewController new];
    mainVC.tabBarItem.image = [UIImage imageNamed:@"home144_110_1"];
    mainVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home144_110_2"];
    mainVC.tabBarItem.title = @"精选";
    UINavigationController * mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    //创建课程分类界面
    CategoryViewController * categoryVC = [CategoryViewController new];
    categoryVC.tabBarItem.image = [UIImage imageNamed:@"all144_110_1"];
    categoryVC.tabBarItem.selectedImage = [UIImage imageNamed:@"all144_110_2"];
    categoryVC.tabBarItem.title = @"分类";
    UINavigationController * categoryNav = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    //创建我的界面
    MyViewController * myVC = [MyViewController new];
    myVC.tabBarItem.image = [UIImage imageNamed:@"my144_110_1"];
    myVC.tabBarItem.selectedImage = [UIImage imageNamed:@"my144_110_2"];
    myVC.tabBarItem.title = @"我的";
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:myVC];
    //创建下载界面
    DownloadViewController * downloadVC = [DownloadViewController new];
    downloadVC.tabBarItem.image = [UIImage imageNamed:@"download144_110_1"];
    downloadVC.tabBarItem.selectedImage = [UIImage imageNamed:@"download144_110_2"];
    downloadVC.tabBarItem.title = @"下载";
    UINavigationController * downloadNav = [[UINavigationController alloc] initWithRootViewController:downloadVC];
    //设置tabbar的字控制器
    self.viewControllers = @[mainNav,categoryNav,nav3,downloadNav];
    //默认选中主界面
    self.selectedIndex = 0;
    
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
