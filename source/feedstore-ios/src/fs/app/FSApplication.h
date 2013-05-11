//
//  FSAppDelegate.h
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSRootViewController;

@interface FSApplication : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) FSRootViewController *rootViewController;

+ (FSApplication *)sharedInstance;

@end
