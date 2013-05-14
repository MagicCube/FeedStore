//
//  FSFeedDetailViewController.h
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTCoreText.h"

@interface FSEntryDetailSceneController : UIViewController <DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

@property (assign, nonatomic) NSDictionary *entry;
@property (readonly, strong, nonatomic) UILabel *titleLabel;
@property (readonly, strong, nonatomic) DTAttributedTextView *textView;

+ (FSEntryDetailSceneController *)sharedInstance;

@end
