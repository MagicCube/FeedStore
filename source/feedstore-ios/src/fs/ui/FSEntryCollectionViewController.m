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
    
    [self beginUpdate];
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
    [cell renderEntry:entry withColWidth:collectionView.colWidth];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    NSDictionary *entry = _entries[index];
    return [FSEntryCollectionViewCell sizeOfCell:entry withColWidth:collectionView.colWidth].height;
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
        [self endUpdate];
        
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            [_entries addObjectsFromArray:responseObject];
            [self.collectionView reloadData];
        }
    }
  
     
                              failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self endUpdate];
         NSLog(@"Error: %@", error);
    }];
}

- (void)beginUpdate
{
    [super beginUpdate];
    
    [_entries removeAllObjects];
    [self loadEntries];
}




- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    FSNavigationController *navigationController = [FSNavigationController sharedInstance];
    FSEntryDetailSceneController *detailSceneController = [FSEntryDetailSceneController sharedInstance];
    [navigationController pushViewController:detailSceneController animated:YES];
}

@end
