//
//  AppDelegate.m
//  NextFlix
//
//  Created by Ronan on 16/04/2015.
//  Copyright (c) 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONAppDelegate.h"
#import "MBProgressHUD.h"
#import "SONDefines.h"

@interface SONAppDelegate ()

@end

@implementation SONAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kPopularMoviesShowLoadingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kPopularMoviesUpdatedNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [MBProgressHUD hideHUDForView:self.window animated:YES];
    }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
