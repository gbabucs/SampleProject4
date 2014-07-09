//
//  AppDelegate.m
//  SampleProject4
//
//  Created by bala on 12/13/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "AppDelegate.h"
#import "Constant.h"
#import "ViewController.h"

#import "YDownload.h"

@implementation AppDelegate

int screenWidth;
int screenHeight;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
     
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    UIDevice* thisDevice = [UIDevice currentDevice];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        Device = IPAD;
    }
    else
    {
        Device  = OTHERDEVICE;
    }
    
    ScreenHeightRatio =  768.0f/[[UIScreen mainScreen] bounds].size.width;
    ScreenWidthRatio = 1024.0f/[[UIScreen mainScreen] bounds].size.height;
       
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    self.viewController = [[ViewController alloc] initWithFrame:self.window.frame];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];    
    
    disableTouch = NO;
    //YDownload *videoDownlaoder = [[YDownload alloc] init];
   // [self.window addSubview:videoDownlaoder.videoView];
   // [videoDownlaoder downloadVideo:[NSURL URLWithString:@"http://youtube.com/watch?v=J9H8gKxlvlc"]];
    
    return YES;

}



- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {    
}


- (NSUInteger)supportedInterfaceOrientations{
     return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft ;
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
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
