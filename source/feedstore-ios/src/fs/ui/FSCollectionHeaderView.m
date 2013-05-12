//
//  FSCollectionHeaderView.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSCollectionHeaderView.h"

@implementation FSCollectionHeaderView

@synthesize hintLabel = _hintLabel;
@synthesize lastUpateTimeLabel = _lastUpateTimeLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = CGRectMake(0, -450, 0, 500);
        
        UIImage *image = [UIImage imageWithContentsOfFile:[FSResource pathForImage:@"logo"]];
        UIImageView *logoView = [[UIImageView alloc] initWithImage:image];
        logoView.frame = CGRectMake(0, 455, 0, 40);
        logoView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        logoView.contentMode = UIViewContentModeCenter;
        [self addSubview:logoView];
        
        
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 405, 0, 20)];
        _hintLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _hintLabel.text = localize(@"Pull to refresh");
        _hintLabel.textAlignment = UITextAlignmentCenter;
        _hintLabel.textColor = rgbhex(0x55606c);
        _hintLabel.backgroundColor = [UIColor clearColor];
        _hintLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:_hintLabel];
        
        _lastUpateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 425, 0, 20)];
        _lastUpateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _lastUpateTimeLabel.text = localize(@"Not updated yet");
        _lastUpateTimeLabel.textAlignment = UITextAlignmentCenter;
        _lastUpateTimeLabel.textColor = rgbhex(0x55606c);
        _lastUpateTimeLabel.backgroundColor = [UIColor clearColor];
        _lastUpateTimeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_lastUpateTimeLabel];
    }
    return self;
}

@end
