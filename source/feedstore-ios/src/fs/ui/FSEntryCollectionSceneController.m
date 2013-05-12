//
//  FSEntryCollectionSceneController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSEntryCollectionSceneController.h"
#import "FSEntryCollectionViewController.h"

@implementation FSEntryCollectionSceneController

@synthesize collectionViewController = _collectionViewController;

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

+ (FSEntryCollectionSceneController *)sharedInstance
{
    static dispatch_once_t pred;
    static FSEntryCollectionSceneController *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[FSEntryCollectionSceneController alloc] init];
    });
    return shared;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = rgbhex(0xdbdfe3);
    self.view.layer.cornerRadius = 3;
    
    _collectionViewController = [[FSEntryCollectionViewController alloc] init];
    _collectionViewController.view.autoresizesSubviews = YES;
    _collectionViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_collectionViewController.view];
}

@end
