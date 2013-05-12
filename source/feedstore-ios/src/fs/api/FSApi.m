//
//  FSApi.m
//  FeedStore
//
//  Created by Henry Li on 13-5-12.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSApi.h"

@implementation FSApi

+ (NSURL *)getBaseURL
{
    static NSURL *baseURL = nil;
    if (baseURL == nil)
    {
        NSString *baseURLString = [NSString stringWithFormat:@"https://%@/api", @"feedstore-01.appspot.com"];
        baseURL = [NSURL URLWithString:baseURLString];
    }
    return baseURL;
}

+ (AFHTTPClient *)createHTTPClient
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL: [FSApi getBaseURL]];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    return client;
}

@end
