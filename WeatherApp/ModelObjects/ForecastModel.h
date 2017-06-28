//
//  ForecastModel.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ForecastDayModel.h"

@protocol ForecastDayModel;


@interface ForecastModel : JSONModel

@property (nonatomic) NSArray <ForecastDayModel> *forecastDays;

@end
