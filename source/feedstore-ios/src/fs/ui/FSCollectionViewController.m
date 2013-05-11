//
//  FSCollectionViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSCollectionViewController.h"
#import "PSCollectionView.h"

@implementation FSCollectionViewController

@synthesize collectionView = _collectionView;

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
    if (_collectionView == nil)
    {
        _collectionView = [[PSCollectionView alloc] init];
        if ([UIDevice currentDevice].isPad)
        {
            _collectionView.numColsPortrait = 3;
            _collectionView.numColsLandscape = 4;
        }
        else
        {
            _collectionView.numColsPortrait = 2;
            _collectionView.numColsLandscape = 2;
        }
    }
    _collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
    _collectionView.collectionViewDataSource = self;
    _collectionView.collectionViewDelegate = self;
    self.view = _collectionView;
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




- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return 0;
}

- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index
{
    return [PSCollectionViewCell class];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    PSCollectionViewCell *cell = nil;
    cell = [collectionView dequeueReusableViewForClass:[PSCollectionViewCell class]];
    if (cell == nil)
    {
        Class cellClass = [self collectionView:collectionView cellClassForRowAtIndex:index];
        cell = [[cellClass alloc] init];
    }
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 128;
}

@end