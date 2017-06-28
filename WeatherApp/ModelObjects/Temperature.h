//
//  Temperature.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Temperature : JSONModel

@property (nonatomic) NSString* fahrenheit;
@property (nonatomic) NSString* celsius;


@end
