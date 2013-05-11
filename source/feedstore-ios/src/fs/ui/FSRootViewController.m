//
//  FSRootViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSEntryCollectionSceneController.h"
#import "FSRootViewController.h"

@implementation FSRootViewController

@synthesize navigationController = _navigationController;

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    FSEntryCollectionSceneController *collectionSceneController = [[FSEntryCollectionSceneController alloc] init];
    _navigationController = [[FSNavigationController alloc] initWithRootViewController:collectionSceneController];
    _navigationController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
    [self.view addSubview:_navigationController.view];
}

@end
