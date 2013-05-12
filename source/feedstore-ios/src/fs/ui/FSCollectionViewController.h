//
//  FSCollectionViewController.h
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../ps/ui/PSCollectionView.h"
@class FSCollectionHeaderView;
@class FSCollectionFooterView;

@interface FSCollectionViewController : UIViewController <PSCollectionViewDelegate, PSCollectionViewDataSource, UIScrollViewDelegate>

@property (readonly, nonatomic) BOOL updating;
@property (readonly, nonatomic) BOOL loading;
@property (strong, nonatomic) NSDate *lastUpdatedTime;
@property (readonly, strong, nonatomic) PSCollectionView *collectionView;
@property (readonly, strong, nonatomic) FSCollectionHeaderView *headerView;
@property (readonly, strong, nonatomic) FSCollectionFooterView *footerView;

- (void)beginUpdate;
- (void)endUpdate;

@end
