//
//  CommonUtility.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GMCommonUtility : JSONModel

/**
 * This will create the path parameter to trigger service call
 * @discussion any selected city in the format of "Charlotte, North Carolina" should be converted to baseUrl/_North_Carolina/Charlotte to trigger the service call to get the weather forecast
 * @param selectedCity in the format of "Charlotte, North Carolina"
 @ returns formated string in the format of "_North_Carolina/Charlotte"
*/
+(NSString*)createPathParamForCity:(NSString*)selectedCity;

@end
