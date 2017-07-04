//
//  CommonUtility.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "GMCommonUtility.h"

@implementation GMCommonUtility


+(NSString*)createPathParamForCity:(NSString*)selectedCity{
    NSArray *cityArray = [selectedCity componentsSeparatedByString:@","];
    NSString *city = @"";
    NSString *state = @"";
    
    if([cityArray count]==2){
        city = [cityArray firstObject];
        state = [cityArray lastObject];
    }
    
    if(city.length > 0 && state.length > 0){
        return [NSString stringWithFormat:@"%@/%@",[state stringByReplacingOccurrencesOfString:@" " withString:@"_"],[city stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    }
    
    return nil;
}

@end
