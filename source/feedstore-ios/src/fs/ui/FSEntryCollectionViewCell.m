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
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLabel];
        
        static int labelCount = 0;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 100, 40)];
        label.textColor = UIColorHex(0xefefef);
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%d", ++labelCount];
        [self addSubview:label];
    }
    return self;
}

@end
