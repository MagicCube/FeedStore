//
//  FSCollectionViewController.h
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../ps/PSCollectionView.h"

@interface FSCollectionViewController : UIViewController <PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (strong, nonatomic) PSCollectionView *collectionView;

@end
