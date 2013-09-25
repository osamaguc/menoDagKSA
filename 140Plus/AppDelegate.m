//
//  AppDelegate.m
//  140Plus
//
//  Created by ousamaMacBook on 5/25/13.
//  Copyright (c) 2013 MacBook. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	//NSLog(@"My token is: %@", deviceToken);
    NSMutableString *string = [[NSMutableString alloc]init];
    int length = [deviceToken length];
    char const *bytes = [deviceToken bytes];
    for (int i=0; i< length; i++) {
        [string appendString:[NSString stringWithFormat:@"%02.2hhx",bytes[i]]];
    }
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:string forKey:@"deviceToken"];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	//NSLog(@"فشل في الحصول على رمز، الخطأ: %@", error);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *alertMsg;
    NSString *badge;
    NSString *sound;
    
    if( [[userInfo objectForKey:@"aps"] objectForKey:@"alert"] != NULL)
    {
        alertMsg = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    }
    else
    {    alertMsg = @"{no alert message in dictionary}";
    }
    
    if( [[userInfo objectForKey:@"aps"] objectForKey:@"badge"] != NULL)
    {
        badge = [[userInfo objectForKey:@"aps"] objectForKey:@"badge"];
    }
    else
    {    badge = @"{no badge number in dictionary}";
    }
    
    if( [[userInfo objectForKey:@"aps"] objectForKey:@"sound"] != NULL)
    {
        sound = [[userInfo objectForKey:@"aps"] objectForKey:@"sound"];
    }
    else
    {
        sound = @"{no sound in dictionary}";
    }
    
   // AudioServicesPlaySystemSound(1002);
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ضيفني أضيفك"
                                                    message:alertMsg
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
