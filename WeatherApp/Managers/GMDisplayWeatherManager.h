//
//  DisplayWeatherManager.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMServiceClient.h"

typedef void (^ClientSuccessCallBackBlock) (NSDictionary *responseDict, NSInteger status);
typedef void (^ClientFailureCallBackBlock) (NSError *error, NSInteger status);

static NSString * const ServiceSelectedCity = @"selectedCity";
static NSString * const ServiceCitySearchText = @"searchText";
static NSString * const ServiceNumberOfDays = @"numberOfDays";
static NSString * const ServiceUSCityNames = @"USCityNames";
static NSString * const ServiceWeatherRecord = @"weatherRecord";

@interface GMDisplayWeatherManager : NSObject

/**
 * This triggers the service to get the weather forecast for the selected city
 * @discussion You can use this method to get the weather forecast for next 10 days maximum. You have to provide proper city name with state and number of days to get the forecast
 * @param requestDict - Dictionary to form the request. Kinldy add following parameters. selectedCity and numberOfDays. If number of days are 0 or negative, then you will get weather forecast for 10 days
 * @param successBlock - callback block to be executed on success of the operation
 * @param failureBlock - callback block to be executed on failur of the operation
*/
+(void)getWeatherForecastForTheCity:(NSDictionary *)requestDict success:(ClientSuccessCallBackBlock)successBlock failureBlock:(ClientFailureCallBackBlock)failureBlock;

/**
 * This triggers the service to get all city names in US
 * @discussion You can use this method to get the Cities in the USA by entering free text.
 * @param requestDict - Dictionary to form the request. Kinldy add following parameters. @"searchText" : "Charlotte"
 * @param successBlock - callback block to be executed on success of the operation
 * @param failureBlock - callback block to be executed on failur of the operation
 */
+(void) getAllCitiesWithName:(NSDictionary *)requestDict success:(ClientSuccessCallBackBlock)successBlock failureBlock:(ClientFailureCallBackBlock)failureBlock;

@end
