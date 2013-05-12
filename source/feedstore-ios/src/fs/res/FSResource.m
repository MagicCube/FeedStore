//
//  FSResource.m
//  FeedStore
//
//  Created by Henry Li on 13-5-12.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSResource.h"

@implementation FSResource

+ (NSString *)pathForFile:(NSString *)fileName withExtension:(NSString *)extension
{
    return [[NSBundle mainBundle]pathForResource:fileName ofType:extension];
}

+ (NSString *)pathForPNG:(NSString *)fileName
{
    return [FSResource pathForFile:fileName withExtension:@"png"];
}

+ (NSString *)pathForJPG:(NSString *)fileName
{
    return [FSResource pathForFile:fileName withExtension:@"jpg"];
}

+ (NSString *)pathForImage:(NSString *)fileName
{
    NSString *result = nil;
    result = [FSResource pathForPNG:fileName];
    if (result == nil)
    {
        result = [FSResource pathForJPG:fileName];
    }
    return result;
}

@end
