//
//  CommonUtility.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CommonUtility : JSONModel

+(NSString*)createPathParamForCity:(NSString*)selectedCity;

@end
