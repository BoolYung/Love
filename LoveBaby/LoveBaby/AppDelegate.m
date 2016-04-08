//
//  AppDelegate.m
//  LoveBaby
//
//  Created by 梅阳阳 on 15/4/23.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)setupNavigationBarStyle {
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        // 设置导航条背景颜色，在iOS7才这么用
        [appearance setBarTintColor:[UIColor colorWithRed:0.291 green:0.607 blue:1.000 alpha:1.000]];
        // 设置导航条的返回按钮或者系统按钮的文字颜色，在iOS7才这么用
        [appearance setTintColor:[UIColor whiteColor]];
        // 设置导航条的title文字颜色，在iOS7才这么用
        [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:17], NSFontAttributeName, nil]];
        
    } else {
        // 设置导航条的背景颜色，在iOS7以下才这么用
        [appearance setTintColor:[UIColor colorWithRed:0.291 green:0.607 blue:1.000 alpha:1.000]];
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    application.applicationIconBadgeNumber = 0;
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *rootVC = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [self setupNavigationBarStyle];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    
    [self  initShareSDK];
    
    return YES;
}

- (void)initShareSDK{
    [ShareSDK registerApp:@"1159d32c3b483"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeTencentWeibo),
                            @(SSDKPlatformSubTypeQZone),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformSubTypeQQFriend)]
                onImport:^(SSDKPlatformType paltformType)
    {
        switch (paltformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType ,NSMutableDictionary *appInfo){
        /*
         需要获取appid
         
         
         */
//        switch (platformType)
//        {
//            case SSDKPlatformTypeSinaWeibo:
//                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                [appInfo SSDKSetupSinaWeiboByAppKey:@"1159d32c3b483"
//                                          appSecret:@"4f1faaa0b8a35388327996f2ddff8a3f"
//                                        redirectUri:@"https://itunes.apple.com/cn/app/dan-er-tu-shang-cheng/id894307888?mt=8"
//                                           authType:SSDKAuthTypeBoth];
//                break;
//            case SSDKPlatformTypeWechat:
//                [appInfo SSDKSetupWeChatByAppId:@"1159d32c3b483"
//                                      appSecret:@"4f1faaa0b8a35388327996f2ddff8a3f"];
//                break;
//            case SSDKPlatformTypeQQ:
//                [appInfo SSDKSetupQQByAppId:@"1159d32c3b483"
//                                     appKey:@"1159d32c3b483"
//                                   authType:SSDKAuthTypeBoth];
//                break;
//            default:
//                break;
//        }
    }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
