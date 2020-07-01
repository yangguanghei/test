//
//  AppDelegate.m
//  0.题
//
//  Created by 中创 on 2020/3/13.
//  Copyright © 2020 LS. All rights reserved.
//

#import "AppDelegate.h"

#import "NSObject+AFCrashExtension.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSObject becomeActive];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = nav;
   
    
    NSLog(@"%s:nav:%p", __func__, nav);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotification:) name:@"testNotification" object:nil];
    
    return YES;
}


- (void)testNotification:(NSNotification *)noti{
    NSLog(@"响应通知的当前线程：%@", [NSThread currentThread]);
    NSLog(@"收到通知:%@", noti.userInfo);
    sleep(3);
    NSLog(@"执行完通知的操作...");
}


#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
