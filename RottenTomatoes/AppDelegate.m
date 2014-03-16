//
//  AppDelegate.m
//  RottenTomatoes
//
//  Created by Nicolas Halper on 3/13/14.
//  Copyright (c) 2014 Nicolas Halper. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // setup initial views
    MoviesViewController *mvc = [[MoviesViewController alloc] init];
    mvc.apiURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t";
    mvc.navigationItem.title = @"Movies";
   
    MoviesViewController *bvc = [[MoviesViewController alloc] init];
    bvc.apiURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t";
    bvc.navigationItem.title = @"Box Office";
    
    MoviesViewController *dvc = [[MoviesViewController alloc] init];
    dvc.apiURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/current_releases.json?apikey=dnr7gjmesk2tm5vmvvvzrf6t";
    dvc.navigationItem.title = @"Current DVDs";
    
    UINavigationController *firstnc = [[UINavigationController alloc] initWithRootViewController:mvc];
    firstnc.tabBarItem.title = @"Movies";
    
    UINavigationController *secondnc = [[UINavigationController alloc] initWithRootViewController:bvc];
    secondnc.tabBarItem.title = @"Box Office";
    
    UINavigationController *thirdnc = [[UINavigationController alloc] initWithRootViewController:dvc];
    thirdnc.tabBarItem.title = @"DVDs";
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = @[firstnc,secondnc,thirdnc];
    
    
    
    self.window.rootViewController = tbc;
    
    
    
    
    // placeholder code for customizing navigation bar
    UINavigationBar *nb = firstnc.navigationBar;
    UIImage *image = [UIImage imageNamed:@"MoviePlaceholder.png"];
    [nb setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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

@end
