//
//  ServiceClient.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * @brief Web Service Client for the Views/Controllers
 * @remarks To trigger webservice APIs requested and get back with the result of operation
 */

typedef void (^GMSuccessCallBackBlock) (id responseObject, NSInteger status);
typedef void (^GMFailureCallBackBlock) (NSError *error, NSInteger status);

@interface GMServiceClient : NSObject

- (instancetype)initWithBaseURLString: (NSString *)urlString;

+ (void)call: (NSString*) serviceName success: (GMSuccessCallBackBlock) successBlock failure:(GMFailureCallBackBlock)failureBlock;
@end
