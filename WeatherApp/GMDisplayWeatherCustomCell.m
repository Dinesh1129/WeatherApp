//
//  DisplayWeatherCustomCell.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/28/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "GMDisplayWeatherCustomCell.h"
#import "DateModel.h"

@implementation GMDisplayWeatherCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIWithModel:(ForecastDayModel*)dayForecast{
    
    DateModel *dateModel = dayForecast.date;
    Temperature *tempHighModel = dayForecast.high;
    Temperature *tempLowModel = dayForecast.low;
    
    self.dateLabel.text = dateModel.pretty;
    self.temHighLabel.text = [NSString stringWithFormat:@"Temperature High: %@°F|%@°C",tempHighModel.fahrenheit,tempHighModel.celsius];
    self.tempLowLabel.text = [NSString stringWithFormat:@"Temperature Low: %@°F|%@°C",tempLowModel.fahrenheit,tempLowModel.celsius];
    self.conditionLabel.text = dayForecast.conditions;
}

@end
