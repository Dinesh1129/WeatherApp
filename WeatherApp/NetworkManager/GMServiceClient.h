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

/**
 * This triggers the request for the serviceName provided.
 * @discussion You can use this convenience method when you just need the clinet for triggering service requests without much networking configuration
 * @param serviceName - Name of the service to be be triggered.
 * @param successBlock - callback block to be executed on success of the operation
 * @param failureBlock - callback block to be executed on failure of the operation
*/

+ (void)call: (NSString*) serviceName success: (GMSuccessCallBackBlock) successBlock failure:(GMFailureCallBackBlock)failureBlock;

@end
