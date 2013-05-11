//
//  FSFeedDetailViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSEntryDetailSceneController.h"

@implementation FSEntryDetailSceneController

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

+ (FSEntryDetailSceneController *)sharedInstance
{
    static dispatch_once_t pred;
    static FSEntryDetailSceneController *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[FSEntryDetailSceneController alloc] init];
    });
    return shared;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 3;
}

@end
