//
//  AppDelegate.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/12.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "AppDelegate.h"
#import "DIYTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置全局导航栏标题颜色为白色
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //设置全局导航栏颜色为浅黑色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithWhite:0.2 alpha:1]];
    //设置全局导航栏item标题颜色为白色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //设置全局状态栏文字颜色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //以tabbar作为根视图
    DIYTabbarController * tabbar = [DIYTabbarController new];
    self.window.rootViewController = tabbar;
    [self login];
    return YES;
}

- (void)login{
    [[HttpRequest sharedInstance] postWithURLString:[NSString stringWithFormat:@"%@?m=App&a=login",BaseUrl] parameters:@{@"password":@"csl19920714",@"username":@"14716987663"} success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
