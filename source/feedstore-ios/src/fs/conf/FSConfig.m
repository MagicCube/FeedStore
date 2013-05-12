//
//  FSConfiguration.m
//  FeedStore
//
//  Created by Henry Li on 13-5-12.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSConfig.h"

@implementation FSConfig

+ (NSDictionary *)settings
{
    static NSDictionary *_settings = nil;
    if (_settings == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"App-Config" ofType:@"plist"];
        _settings = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _settings;
}


+ (id)settingWithKey:(NSString *)key defaultValue:(id)defaultValue
{
    id value = [FSConfig settings][key];
    if (value == nil)
    {
        return defaultValue;
    }
    return value;
}

+ (id)settingWithKey:(NSString *)key
{
    return [FSConfig settingWithKey:key defaultValue:nil];
}

@end
