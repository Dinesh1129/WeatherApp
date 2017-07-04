//
//  DisplayWeatherVC.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "GMDisplayWeatherVC.h"
#import "GMDisplayWeatherManager.h"
#import "DateModel.h"
#import "ForecastDayModel.h"
#import "Temperature.h"
#import "GMDisplayWeatherCustomCell.h"

@interface GMDisplayWeatherVC ()
{
    UIActivityIndicatorView *serviceActivityIndicator;
}

@property (nonatomic, strong) NSArray *weatherData;

@end

@implementation GMDisplayWeatherVC

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Activity Indicator - TODO
    serviceActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [serviceActivityIndicator setCenter:self.view.center];
    [self.view addSubview:serviceActivityIndicator];
    
    [serviceActivityIndicator startAnimating];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:self.selectedCity,[NSNumber numberWithInt:3], nil] forKeys:[NSArray arrayWithObjects:@"selectedCity",@"numberOfDays",nil]];
    
    [GMDisplayWeatherManager getWeatherForecastForTheCity:requestDict success:^(NSDictionary *responseDict, NSInteger status) {
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
    
    GMDisplayWeatherCustomCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell"];
    
    ForecastDayModel *dayForecast = [self.weatherData objectAtIndex:indexPath.row];
    
    //TO-DO
    if(dayForecast != nil){
        [tableCell updateUIWithModel:dayForecast];
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
