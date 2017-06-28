//
//  SelectCityVC.h
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCityVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property (weak, nonatomic) IBOutlet UIButton *getWeatherBtn;

- (IBAction)getWeatherBtnTapped:(id)sender;

@end
