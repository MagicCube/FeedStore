//
//  FSFeedCollectionViewController.h
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSCollectionViewController.h"

@interface FSEntryCollectionViewController : FSCollectionViewController

@property (strong, nonatomic) NSMutableArray *entries;

- (void)loadEntries;
- (void)reloadEntries;

@end
