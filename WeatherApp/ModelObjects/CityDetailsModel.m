//
//  CityDetailsModel.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "CityDetailsModel.h"

@implementation CityDetailsModel

+ (JSONKeyMapper *)keyMapper{
return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                              @"cityDetails" : @"RESULTS"
                                                              }];
}
@end
