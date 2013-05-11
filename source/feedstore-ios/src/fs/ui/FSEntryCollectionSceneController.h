//
//  FSEntryCollectionSceneController.h
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSEntryCollectionViewController;

@interface FSEntryCollectionSceneController : UIViewController

@property (readonly, strong, nonatomic) FSEntryCollectionViewController *collectionViewController;

+ (FSEntryCollectionSceneController *)sharedInstance;

@end
