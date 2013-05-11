//
//  FSFeedCollectionViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSEntryCollectionViewController.h"
#import "FSEntryCollectionViewCell.h"
#import "FSEntryDetailSceneController.h"

@implementation FSEntryCollectionViewController

@synthesize entries = _entries;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"FeedStore";
        _entries = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, -40, 0, 80);
    [button setTitle:@"下拉刷新" forState:UIControlStateNormal];
    self.collectionView.headerView = button;
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 0, 40);
    [button setTitle:@"上拉继续加载" forState:UIControlStateNormal];
    self.collectionView.footerView = button;
    
    [self loadEntries];
}






- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return _entries.count;
}

- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index
{
    return [FSEntryCollectionViewCell class];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    FSEntryCollectionViewCell *cell = (FSEntryCollectionViewCell *)[super collectionView:collectionView cellForRowAtIndex:index];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", index + 1];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    NSDictionary *entry = _entries[index];
    NSNumber *height = (NSNumber *)entry[@"height"];
    return [height floatValue];
}




- (void)loadEntries
{
    for (NSInteger i = 0; i < 20; i++)
    {
        NSDictionary *entry = @{ @"height": [NSNumber numberWithInt:(128 + arc4random() % 64)] };
        [_entries addObject:entry];
    }
    
    [super.collectionView reloadData];
}




- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    FSNavigationController *navigationController = [FSNavigationController sharedInstance];
    FSEntryDetailSceneController *detailSceneController = [FSEntryDetailSceneController sharedInstance];
    [navigationController pushViewController:detailSceneController animated:YES];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int deltaY = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height;
    
    if (deltaY <= 20)
    {
        [self loadEntries];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

@end
