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
    
    [self reloadEntries];
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
    NSDictionary *entry = _entries[index];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", entry[@"title"]];
    
    cell.textLabel.frame = CGRectMake(5, 0, collectionView.colWidth - 10, 20);
    
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    NSDictionary *entry = _entries[index];
    NSDictionary *image = entry[@"image"];
    NSNumber *height = nil;
    if ([image valueForKey:@"height"] != [NSNull null])
    {
        NSNumber *imageWidth = nil;
        NSNumber *imageHeight = nil;

        imageHeight = [image valueForKey:@"height"];
        imageWidth = [image valueForKey:@"width"];
        float ratio = collectionView.colWidth / imageWidth.floatValue;
        height = [NSNumber numberWithFloat:ratio * imageHeight.floatValue];
    }
    
    if (height == nil)
    {
        height = [NSNumber numberWithFloat:128];
    }
    return height.floatValue;
}



- (void)loadEntries
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *after = nil;
    if (_entries.count > 0)
    {
        after = _entries.lastObject[@"id"];
    }
    
    int count = 20;
    if ([UIDevice currentDevice].isPad)
    {
        count = 25;
    }
    
    [[FSApi createHTTPClient] getPath:@"entry"
                           parameters:@{ @"count": [NSNumber numberWithInt:count], @"after": (after != nil ? after : [NSNull null]) }
                              success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            [_entries addObjectsFromArray:responseObject];
            [self.collectionView reloadData];
        }
    }
  
     
                              failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"Error: %@", error);
    }];
}

- (void)reloadEntries
{
    [_entries removeAllObjects];
    
    [self loadEntries];
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
