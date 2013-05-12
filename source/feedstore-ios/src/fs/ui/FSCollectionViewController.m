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

@synthesize updating = _updating;
@synthesize loading = _loading;
@synthesize lastUpdatedTime = _lastUpdatedTime;
@synthesize collectionView = _collectionView;
@synthesize headerView = _headerView;
@synthesize footerView = _footerView;

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


- (void)setLastUpdatedTime:(NSDate *)lastUpdatedTime
{
    _lastUpdatedTime = lastUpdatedTime;
    if (_headerView != nil)
    {        
        NSString *timeString = [MXDateUtil formatDateFuzzy:_lastUpdatedTime];
        _headerView.lastUpateTimeLabel.text = [NSString stringWithFormat:localize(@"Last updated at"), timeString];
    }
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
    
    
    _headerView = [[FSCollectionHeaderView alloc] init];
    _collectionView.headerView = _headerView;
    if (_lastUpdatedTime != nil)
    {
        [self setLastUpdatedTime:_lastUpdatedTime];
    }
    
    _footerView = [[FSCollectionFooterView alloc] init];
    _footerView.frame = CGRectMake(0, 0, 0, 40);
    _collectionView.footerView = _footerView;
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


- (void)beginUpdate
{
    if (_loading || _updating) return;
    
    _updating = YES;
    _headerView.hintLabel.text = localize(@"Updating");
    [UIView beginAnimations:nil context:nil];
    [self.collectionView setContentInset:UIEdgeInsetsMake(55, 0, 0, 0)];
    [UIView commitAnimations];
    self.collectionView.userInteractionEnabled = NO;
}

- (void)endUpdate
{
    if (!_updating) return;
    
    [self setLastUpdatedTime:[[NSDate alloc] init]];
    _updating = NO;
    _headerView.hintLabel.text = localize(@"Pull to refresh");
    [UIView beginAnimations:nil context:nil];
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [UIView commitAnimations];
    self.collectionView.userInteractionEnabled = YES;
}

- (void)beginLoad
{
    if (_loading || _updating) return;
    
    _loading = YES;
}

- (void)endLoad
{
    if (!_loading) return;
    
    _loading = NO;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_updating || _loading) return;
    
    if (scrollView.contentOffset.y < -55)
    {
        _headerView.hintLabel.text = localize(@"Release to refresh");
    }
    else
    {
        _headerView.hintLabel.text = localize(@"Pull to refresh");
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < 0)
    {
        [self setLastUpdatedTime:_lastUpdatedTime];
    }
    if (scrollView.contentOffset.y < -55)
    {
        [self beginUpdate];
    }
    
    if (!decelerate)
    {
        [self scrollViewDidEndDecelerating:(UIScrollView *)scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y - scrollView.contentSize.height - scrollView.frame.size.height < 20)
    {
        [self beginLoad];
    }
}

@end
