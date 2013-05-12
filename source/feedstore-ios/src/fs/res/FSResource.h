//
//  FSResource.h
//  FeedStore
//
//  Created by Henry Li on 13-5-12.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSResource : NSObject

+ (NSString *)pathForFile:(NSString *)fileName withExtension:(NSString *)extension;
+ (NSString *)pathForPNG:(NSString *)fileName;
+ (NSString *)pathForJPG:(NSString *)fileName;
+ (NSString *)pathForImage:(NSString *)fileName;

@end
