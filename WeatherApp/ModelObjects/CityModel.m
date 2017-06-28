//
//  CityModel.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

+ (JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"cityName" : @"name",
                                                                  @"country" : @"c"
                                                                  }];
}
@end
