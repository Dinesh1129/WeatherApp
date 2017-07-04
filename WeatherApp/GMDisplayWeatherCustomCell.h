//
//  DisplayWeatherCustomCell.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/28/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastDayModel.h"

@interface GMDisplayWeatherCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *temHighLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLowLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;

- (void)updateUIWithModel:(ForecastDayModel*)dayForecast;

@end
