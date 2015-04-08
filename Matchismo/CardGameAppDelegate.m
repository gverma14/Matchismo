//
//  CardGameAppDelegate.m
//  Matchismo
//
//  Created by Gaurav Verma on 6/28/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "CardGameAppDelegate.h"
#import "CardGameViewController.h"

@interface CardGameAppDelegate ()

@property (nonatomic, strong) NSMutableArray *viewControllersToBeSaved;

@end
@implementation CardGameAppDelegate



-(NSMutableArray *)viewControllersToBeSaved
{
    if (!_viewControllersToBeSaved) {
        _viewControllersToBeSaved = [[NSMutableArray alloc] init];
    }
    
    return _viewControllersToBeSaved;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    UIViewController *viewController = self.window.rootViewController;
    
    NSLog(@"Root View Controller Class: %@", [viewController class]);
    
    NSArray *childRootViewControllers = viewController.childViewControllers;
    
    for (UIViewController *childViewController in childRootViewControllers) {
        NSArray *grandChildRootViewControllers = childViewController.childViewControllers;
        
        
        for (UIViewController *grandChildRootViewController in grandChildRootViewControllers) {
            if ([grandChildRootViewController isKindOfClass:[CardGameViewController class]]) {
                 [self.viewControllersToBeSaved addObject:(CardGameViewController *) grandChildRootViewController];
                
            }
        }
    }
    
    //NSLog(@"View Controller Class: %@", [self.viewController class]);
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
    if ([self.viewControllersToBeSaved count]) {
        for (id viewController in self.viewControllersToBeSaved) {
            if ([viewController isKindOfClass:[CardGameViewController class]]) {
                [viewController setHighScore];
            }
        }
    }
}

@end
