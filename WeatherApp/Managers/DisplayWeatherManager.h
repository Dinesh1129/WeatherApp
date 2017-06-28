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

@interface DisplayWeatherManager : NSObject


-(void)getWeatherForecastForTheCity:(NSDictionary *)requestDict success:(ClientSuccessCallBackBlock)successBlock failureBlock:(ClientFailureCallBackBlock)failureBlock;
- (void) getAllCitiesWithName:(NSDictionary *)requestDict success:(ClientSuccessCallBackBlock)successBlock failureBlock:(ClientFailureCallBackBlock)failureBlock;

@end
