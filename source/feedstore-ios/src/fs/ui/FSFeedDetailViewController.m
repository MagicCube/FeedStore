//
//  FSFeedDetailViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSFeedDetailViewController.h"

@implementation FSFeedDetailViewController

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

+ (FSFeedDetailViewController *)sharedInstance
{
    static dispatch_once_t pred;
    static FSFeedDetailViewController *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[FSFeedDetailViewController alloc] init];
    });
    return shared;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 3;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [button addTarget:self action:@selector(_onclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)_onclick
{
    [[FSNavigationController sharedInstance] popViewControllerAnimated:YES];
}

@end
