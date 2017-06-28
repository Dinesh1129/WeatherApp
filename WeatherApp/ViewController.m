//
//  ViewController.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "ViewController.h"
#import "DisplayWeatherManager.h"
@interface ViewController ()
{
    DisplayWeatherManager *displayWeatherManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    displayWeatherManager = [[DisplayWeatherManager alloc]init];
    
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"Charlotte, North Carolina",[NSNumber numberWithInt:3], nil] forKeys:[NSArray arrayWithObjects:<#(nonnull id), ...#>, nil]]
    
    [displayWeatherManager getWeatherForecastForTheCity:@"Charlotte, North Carolina" numberOfDays:3];
    [displayWeatherManager getAllCitiesWithName:@"Charlotte"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
