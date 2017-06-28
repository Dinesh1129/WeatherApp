//
//  ForecastModel.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "ForecastModel.h"

@implementation ForecastModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"forecastDays" : @"forecast.simpleforecast.forecastday",
                                                                  }];
}
@end

