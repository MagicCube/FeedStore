//
//  FSCollectionViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSCollectionViewController.h"
#import "FSCollectionHeaderView.h"
#import "FSCollectionFooterView.h"
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
    _collectionView.delegate = self;
    _collectionView.collectionViewDataSource = self;
    _collectionView.collectionViewDelegate = self;
    self.view = _collectionView;
    
    
    FSCollectionHeaderView *headView = [[FSCollectionHeaderView alloc] init];
    
    _collectionView.headerView = headView;
    
    FSCollectionFooterView *footerView = [[FSCollectionFooterView alloc] init];
    footerView.frame = CGRectMake(0, 0, 0, 40);
    _collectionView.footerView = footerView;
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
    Class cellClass = [self collectionView:collectionView cellClassForRowAtIndex:index];
    
    PSCollectionViewCell *cell = nil;
    cell = [collectionView dequeueReusableViewForClass:cellClass];
    if (cell == nil)
    {
        cell = [[cellClass alloc] init];
    }
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 128;
}

@end
