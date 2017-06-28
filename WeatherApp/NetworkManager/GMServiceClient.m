//
//  ServiceClient.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "GMServiceClient.h"
#import "GMHTTPSessionManager.h"


@interface GMServiceClient()
{
    GMHTTPSessionManager *sessionManager;
}

@end

@implementation GMServiceClient

-(instancetype)initWithBaseURLString:(NSString *)urlString{
    if (self = [super init]) {
        sessionManager = [[GMHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
    }
    
    return self;
}

+(void)call:(NSString *)serviceName success:(GMSuccessCallBackBlock)successBlock failure:(GMFailureCallBackBlock)failureBlock{
    [[[self class] new] call:serviceName  success:successBlock failure:failureBlock];
}

-(void)call:(NSString *)serviceName success: (GMSuccessCallBackBlock) successBlock failure:(GMFailureCallBackBlock)failureBlock{
    sessionManager = [[GMHTTPSessionManager alloc] init];
    [sessionManager GET:serviceName parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        successBlock(responseObject, 200);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR: %@", error);
        successBlock(error, 200);
    }];
}

@end
