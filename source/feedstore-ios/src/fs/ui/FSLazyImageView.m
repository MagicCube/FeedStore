//
//  FSImageView.m
//  FeedStore
//
//  Created by Henry Li on 13-5-12.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSLazyImageView.h"

@implementation FSLazyImageView

@synthesize url = _url;

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

- (void)setUrl:(NSURL *)url
{
    if (_url != url)
    {
        _url = url;
        self.image = nil;
        if (url != nil)
        {
            [self setImageWithURL:url];
        }
    }
}
@end
