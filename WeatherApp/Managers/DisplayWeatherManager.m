//
//  DisplayWeatherManager.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "DisplayWeatherManager.h"
#import "ForecastModel.h"
#import "ForecastDayModel.h"
#import "CityDetailsModel.h"
#import "CityModel.h"
#import "CommonUtility.h"




@implementation DisplayWeatherManager


-(void)getWeatherForecastForTheCity:(NSDictionary * )requestDict success:(ClientSuccessCallBackBlock)successBlock failureBlock:(ClientFailureCallBackBlock)failureBlock{
    
    NSString *selectedCity = [requestDict objectForKey:ServiceSelectedCity];
    __block NSNumber *numberOfDays = [requestDict objectForKey:ServiceNumberOfDays];
    
    NSString *finalURL = [NSString stringWithFormat:@"http://api.wunderground.com/api/59641563fdf5ea17/forecast10day/q/%@.json",[CommonUtility createPathParamForCity:selectedCity]];
    
    [GMServiceClient call:finalURL success:^(id responseObject, NSInteger status) {
        NSError *error;
        ForecastModel *foreCast = [[ForecastModel alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"Forecast: %@", foreCast.forecastDays);
        
        //Webservice can return only 10 records
        if (numberOfDays.integerValue < 0 || numberOfDays.integerValue > 10) {
            numberOfDays = [NSNumber numberWithInt:10] ;
        }
        NSArray *filteredArray = [foreCast.forecastDays subarrayWithRange:NSMakeRange(0, numberOfDays.integerValue)];
        NSMutableDictionary *responseDict = [[NSMutableDictionary alloc] init];
        [responseDict setObject:filteredArray forKey:ServiceWeatherRecord];
        successBlock(responseDict,status);
        
    } failure:^(NSError *error, NSInteger status) {
        failureBlock(error, status);
    }];
}

-(void)getAllCitiesWithName:(NSDictionary *)requestDict success:(ClientSuccessCallBackBlock)successBlock failureBlock:(ClientFailureCallBackBlock)failureBlock{
    
    NSMutableDictionary *responseDict = [[NSMutableDictionary alloc] init];
    
    NSString *searchText = [requestDict objectForKey:ServiceCitySearchText];

    NSString *finalURL = [NSString stringWithFormat:@"http://autocomplete.wunderground.com/aq?query=%@",[searchText stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    
    [GMServiceClient call:finalURL success:^(id responseObject, NSInteger status) {
        NSError *error;
        CityDetailsModel *cityDetails = [[CityDetailsModel alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"City Details : %@", cityDetails.cityDetails);
        NSArray *filteredArray = [[self class] filterUSCities:cityDetails.cityDetails];
        NSLog(@"US Cities : %@",filteredArray);
        
        [responseDict setObject:filteredArray forKey:ServiceUSCityNames];
        
        successBlock(responseDict,status);

    } failure:^(NSError *error, NSInteger status) {
        failureBlock(error, status);
    }];
}

+(NSArray*)filterUSCities:(NSArray<CityModel>*) cityDetails{
    NSArray *filteredArray = [cityDetails filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(CityModel *city, NSDictionary<NSString *,id> * _Nullable bindings) {
        return ([city.country  isEqualToString: @"US"]);
    }]];
    return filteredArray;
}

@end
