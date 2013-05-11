//
//  FSFeedCollectionViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSFeedCollectionViewController.h"

@interface FSFeedCollectionViewController ()

@end

@implementation FSFeedCollectionViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"FeedStore";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return 100;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    PSCollectionViewCell *cell = [super collectionView:collectionView cellForRowAtIndex:index];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 128 + arc4random() % 256;
}

@end
