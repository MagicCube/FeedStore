//
//  FSRootViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSRootViewController.h"
#import "FSNavigationController.h"

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
    
    _navigationController = [[FSNavigationController alloc] init];
    _navigationController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
    [self.view addSubview:_navigationController.view];
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
