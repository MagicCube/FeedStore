//
//  FSFeedCollectionViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSFeedCollectionViewController.h"
#import "FSFeedCollectionViewCell.h"
#import "FSFeedDetailViewController.h"

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

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = UIColorHex(0xdbdfe3);
    self.view.layer.cornerRadius = 3;
}


- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return 100;
}

- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index
{
    return [FSFeedCollectionViewCell class];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    FSFeedCollectionViewCell *cell = (FSFeedCollectionViewCell *)[super collectionView:collectionView cellForRowAtIndex:index];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", index + 1];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 128 + arc4random() % 256;
}



- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    [[FSNavigationController sharedInstance] pushViewController:[FSFeedDetailViewController sharedInstance] animated:YES];
}

@end
