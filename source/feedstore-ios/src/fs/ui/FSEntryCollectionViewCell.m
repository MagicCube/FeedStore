//
//  FSFeedCollectionViewCell.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSEntryCollectionViewCell.h"
#import "../../ps/ui/PSCollectionView.h"
#import "FSImageView.h"

@implementation FSEntryCollectionViewCell

@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;
@synthesize channelLabel = _channelLabel;
@synthesize infoView = _infoView;
@synthesize publishTimeLabel = _publishTimeLabel;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, 192, 192);
        
        [self _initLayer];
        [self _initInfoView];
        [self _initImageView];
        [self _initTitleLabel];
        [self _initChannelLabel];
        [self _initPublishTimeLabel];
    }
    return self;
}

+ (UIFont *)titleFont
{
    static UIFont *_titleFont = nil;
    if (_titleFont == nil)
    {
        _titleFont = [UIFont systemFontOfSize:13];
    }
    return _titleFont;
}


- (void)_initLayer
{
    CALayer *layer = self.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 6;
    layer.borderWidth = 1;
    layer.borderColor = rgb(178, 178, 178).CGColor;
}

- (void)_initInfoView
{    
    _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 192 - 40, 192, 40)];
    _infoView.backgroundColor = rgb(241, 241, 241);
    _infoView.autoresizesSubviews = YES;
    _infoView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_infoView];
}

- (void)_initImageView
{
    _imageView = [[FSImageView alloc] init];
    _imageView.backgroundColor = rgbhex(0xfafafa);
    [self addSubview:_imageView];
}

- (void)_initTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _titleLabel.font = [FSEntryCollectionViewCell titleFont];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
}

- (void)_initChannelLabel
{
    _channelLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 15)];
    _channelLabel.font = [UIFont systemFontOfSize:12];
    _channelLabel.backgroundColor = [UIColor clearColor];
    [_infoView addSubview:_channelLabel];
}

- (void)_initPublishTimeLabel
{
    _publishTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 100, 15)];
    _publishTimeLabel.font = [UIFont systemFontOfSize:12];
    _publishTimeLabel.textColor = rgb(128, 128, 128);
    _publishTimeLabel.backgroundColor = [UIColor clearColor];
    [_infoView addSubview:_publishTimeLabel];
}



+ (CGSize)imageViewSizeOfEntry:(NSDictionary *)entry withColWidth:(CGFloat)colWidth
{
    CGFloat height = 0;
    NSDictionary *image = entry[@"image"];
    if ([image valueForKey:@"height"] != [NSNull null])
    {
        NSNumber *imageWidth = nil;
        NSNumber *imageHeight = nil;
        
        imageHeight = [image valueForKey:@"height"];
        imageWidth = [image valueForKey:@"width"];
        
        float ratio = colWidth / imageWidth.floatValue;
        height = ratio * imageHeight.floatValue;
    }
    else
    {
        height = colWidth;
    }
    return CGSizeMake(colWidth, height);
}

+ (CGSize)titleSizeOfEntry:(NSDictionary *)entry withColWidth:(CGFloat)colWidth
{
    NSString *title = entry[@"title"];
    CGSize size = [title sizeWithFont:[FSEntryCollectionViewCell titleFont] constrainedToSize:CGSizeMake(colWidth - 14, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}

+ (CGSize)sizeOfCell:(NSDictionary *)entry withColWidth:(CGFloat)colWidth
{
    CGSize imageSize = [FSEntryCollectionViewCell imageViewSizeOfEntry:entry withColWidth:colWidth];
    CGFloat height = imageSize.height;
    
    CGSize titleSize = [FSEntryCollectionViewCell titleSizeOfEntry:entry withColWidth:colWidth];
    height += 5 + titleSize.height + 10;
    height += 40;
    return CGSizeMake(colWidth, height);
}




- (void)renderEntry:(NSDictionary *)entry withColWidth:(CGFloat)colWidth
{
    CGSize size = [FSEntryCollectionViewCell imageViewSizeOfEntry:entry withColWidth:colWidth];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    _imageView.frame = frame;

    _titleLabel.text = entry[@"title"];
    size = [FSEntryCollectionViewCell titleSizeOfEntry:entry withColWidth:colWidth];
    _titleLabel.frame = CGRectMake(7, frame.size.height + 5, colWidth - 14, size.height + 10);
    
    _channelLabel.text = entry[@"channelId"];
    _channelLabel.frame = CGRectMake(7, 1, colWidth - 14, 16);
    
    NSNumber *timeNumber = (NSNumber *)entry[@"storedTime"];
    long long time = [timeNumber longLongValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    _publishTimeLabel.text = [MXDateUtil formatDateFuzzy:date];
    _publishTimeLabel.frame = CGRectMake(7, 20, colWidth - 14, 16);
}

@end
