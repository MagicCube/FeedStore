//
//  FSNavigationController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSNavigationController.h"
#import "FSFeedCollectionViewController.h"

@implementation FSNavigationController

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

    self.view.backgroundColor = UIColorHex(0xdee2e6);
    self.navigationBar.barStyle = UIBarStyleBlackOpaque;
    CALayer *layer = self.navigationBar.layer;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.7f;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 5.0f;
    layer.masksToBounds = NO;
    
    FSFeedCollectionViewController *collectionViewController = [[FSFeedCollectionViewController alloc] init];
    [self pushViewController:collectionViewController animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
