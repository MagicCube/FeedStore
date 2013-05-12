//
//  FSFeedCollectionViewCell.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSEntryCollectionViewCell.h"

@implementation FSEntryCollectionViewCell

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        CALayer *layer = self.layer;
        layer.cornerRadius = 6;
        layer.borderWidth = 1;
        layer.borderColor = UIColorRGB(178, 178, 178).CGColor;
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        self.textLabel.font = [UIFont systemFontOfSize:10];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLabel];
    }
    return self;
}

@end
