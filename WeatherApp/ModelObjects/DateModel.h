//
//  DateModel.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DateModel : JSONModel

@property (nonatomic) NSString* epoch;
@property (nonatomic) NSString* pretty;
@property (nonatomic) NSInteger day;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger hour;
@property (nonatomic) NSString* min;
@property (nonatomic) NSInteger sec;
@property (nonatomic) NSString* isdst;
@property (nonatomic) NSString* monthname_short;
@property (nonatomic) NSString* weekday_short;
@property (nonatomic) NSString* ampm;
@property (nonatomic) NSString* tz_short;
@property (nonatomic) NSString* tz_long;



@end
