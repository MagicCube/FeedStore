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

@synthesize items = _items;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"FeedStore";
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.collectionView.backgroundColor = UIColorHex(0xdbdfe3);
    self.collectionView.layer.cornerRadius = 3;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 0, 40);
    [button setTitle:@"加载" forState:UIControlStateNormal];
    self.collectionView.footerView = button;
    
    [self reloadData];
}






- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return _items.count;
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
    NSDictionary *item = _items[index];
    NSNumber *height = (NSNumber *)item[@"height"];
    return [height floatValue];
}




- (void)reloadData
{
    for (NSInteger i = 0; i < 20; i++)
    {
        NSDictionary *item = @{ @"height": [NSNumber numberWithInt:(128 + arc4random() % 64)] };
        [_items addObject:item];
    }
    
    [super reloadData];
}




- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    FSNavigationController *navigationController = [FSNavigationController sharedInstance];
    FSFeedDetailViewController *detailViewController = [FSFeedDetailViewController sharedInstance];
    [navigationController pushViewController:detailViewController animated:YES];
}

@end
