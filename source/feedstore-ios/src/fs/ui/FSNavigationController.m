//
//  FSNavigationController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSNavigationController.h"

@implementation FSNavigationController

static FSNavigationController *__sharedNavigationController = nil;

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        __sharedNavigationController = self;
    }
    return self;
}

+ (FSNavigationController *)sharedInstance
{
    return __sharedNavigationController;
}

@end
