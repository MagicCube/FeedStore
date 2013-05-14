//
//  FSFeedCollectionViewCell.h
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "PSCollectionViewCell.h"
@class FSLazyImageView;

@interface FSEntryCollectionViewCell : PSCollectionViewCell

@property (readonly, strong, nonatomic) FSLazyImageView *imageView;
@property (readonly, strong, nonatomic) UILabel *titleLabel;
@property (readonly, strong, nonatomic) UIView *infoView;
@property (readonly, strong, nonatomic) UILabel *channelLabel;
@property (readonly, strong, nonatomic) UILabel *publishTimeLabel;

+ (CGSize)sizeOfCell:(NSDictionary *)entry withColWidth:(CGFloat)colWidth;
- (void)renderEntry:(NSDictionary *)entry withColWidth:(CGFloat)colWidth;

@end
