//
//  DisplayWeatherVC.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "DisplayWeatherVC.h"
#import "DisplayWeatherManager.h"
#import "DateModel.h"
#import "ForecastDayModel.h"
#import "Temperature.h"

@interface DisplayWeatherVC ()
{
    DisplayWeatherManager *weatherMgr;
    UIActivityIndicatorView *serviceActivityIndicator;
}

@property (nonatomic, strong) NSArray *weatherData;

@end

@implementation DisplayWeatherVC

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Activity Indicator
    serviceActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [serviceActivityIndicator setCenter:self.view.center];
    [self.view addSubview:serviceActivityIndicator];
    
    //Make Service call to get the weather forecast for three days
    weatherMgr = [[DisplayWeatherManager alloc] init];
    
    
    [serviceActivityIndicator startAnimating];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:self.selectedCity,[NSNumber numberWithInt:3], nil] forKeys:[NSArray arrayWithObjects:@"selectedCity",@"numberOfDays",nil]];
    
    [weatherMgr getWeatherForecastForTheCity:requestDict success:^(NSDictionary *responseDict, NSInteger status) {
        [serviceActivityIndicator stopAnimating];
        self.weatherData = [responseDict objectForKey:ServiceWeatherRecord];
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error, NSInteger status) {
        [serviceActivityIndicator stopAnimating];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell"];
    
    ForecastDayModel *dayForecast = [self.weatherData objectAtIndex:indexPath.row];

    if(dayForecast != nil){
        UILabel *dateLabel = (UILabel*)[tableCell viewWithTag:1];
        UILabel *tempHigh = (UILabel*)[tableCell viewWithTag:2];
        UILabel *tempLow = (UILabel*)[tableCell viewWithTag:3];
        UILabel *condition = (UILabel*)[tableCell viewWithTag:4];
        
        DateModel *dateModel = dayForecast.date;
        Temperature *tempHighModel = dayForecast.high;
        Temperature *tempLowModel = dayForecast.low;
        
        dateLabel.text = dateModel.pretty;
        tempHigh.text = [NSString stringWithFormat:@"%@°F|%@°C",tempHighModel.fahrenheit,tempHighModel.celsius];
        tempLow.text = [NSString stringWithFormat:@"%@°F|%@°C",tempLowModel.fahrenheit,tempLowModel.celsius];
        condition.text = dayForecast.conditions;
    }
    return tableCell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%2 == 0) {
        cell.backgroundColor=[UIColor lightGrayColor];
    }
    else{
        cell.backgroundColor=[UIColor darkGrayColor];
    }
}

@end
