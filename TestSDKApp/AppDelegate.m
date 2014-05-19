//
//  AppDelegate.m
//  TestSDKApp
//
//  Created by Tengai on 12/13/13.
//  Copyright (c) 2013 TestSDKApp. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <PrintIO/PrintIO.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
    
    // Register for push notifications
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [PrintIO registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PrintIO showNotification:userInfo
              backgroundColor:[UIColor colorWithRed:34.0/255.0 green:160.0/255.0 blue:221.0/255.0 alpha:255.0/255.0]
                    textColor:[UIColor whiteColor]];
}

@end
