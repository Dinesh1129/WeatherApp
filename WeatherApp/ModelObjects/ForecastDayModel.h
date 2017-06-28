//
//  ForecastDayModel.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DateModel.h"
#import "Temperature.h"

@interface ForecastDayModel : JSONModel

@property (nonatomic) DateModel* date;
@property (nonatomic) Temperature* high;
@property (nonatomic) Temperature* low;
@property (nonatomic) NSString* conditions;

@end
