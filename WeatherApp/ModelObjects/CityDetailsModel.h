//
//  CityDetailsModel.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CityModel.h"

@protocol CityModel;

@interface CityDetailsModel : JSONModel

@property (nonatomic) NSArray <CityModel> *cityDetails;


@end
