//
//  SelectCityVC.m
//  WeatherApp
//
//  Created by Dinesh Selvaraj on 6/27/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import "SelectCityVC.h"
#import "DisplayWeatherVC.h"
#import "DisplayWeatherManager.h"
#import "CityModel.h"

@interface SelectCityVC ()
{
    DisplayWeatherManager *displayWeatherManager;
    UIActivityIndicatorView *serviceActivityIndicator;
}

@property (nonatomic, strong) NSArray <CityModel *> *cityList;

@end

@implementation SelectCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Hide table view for the initial load
    [self.cityTableView setHidden:YES];
    
    //Enable / Disable the btn based on the text length
    [self.getWeatherBtn setEnabled:[self shouldEnableWeatherBtn:self.cityTextField.text]];

    //Hide weather button during initial load
    displayWeatherManager = [[DisplayWeatherManager alloc]init];
   
    serviceActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [serviceActivityIndicator setCenter:self.view.center];
    [self.view addSubview:serviceActivityIndicator];
}



#pragma mark - UITextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self.getWeatherBtn setEnabled:[self shouldEnableWeatherBtn:finalString]];
    
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    [self.getWeatherBtn setEnabled:[self shouldEnableWeatherBtn:@""]];
    return YES;
}

#pragma mark UITableView Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_cityList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cityCell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    
    if (cityCell == nil) {
        cityCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
    }
    
    [cityCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    CityModel *cityModel = [_cityList objectAtIndex:indexPath.row];
    
    cityCell.textLabel.text = cityModel.cityName;
    
    return cityCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    headerView.backgroundColor = [UIColor greenColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    
    if([self.cityList count]==0){
        [headerLabel setText:@"No results for your search. Make sure you have entered correct city name"];
    }
    else{
        [headerLabel setText:@"There are multiple results. Please select one to get the weather forecast"];
    }

    [headerLabel setNumberOfLines:0];
    [headerLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [headerView addSubview:headerLabel];
    return headerView;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%2 == 0) {
        cell.backgroundColor=[UIColor lightGrayColor];
    }
    else{
        cell.backgroundColor=[UIColor darkGrayColor];
    }
}

#pragma mark - UITable View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"SHOW_WEATHER" sender:self];
}


#pragma mark - Storyboard Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"SHOW_WEATHER"]){
        
        //Get Reference to destination view controller
        DisplayWeatherVC *displayWeatherVC = [segue destinationViewController];
        
        //Set any properties you want
        CityModel *selectedCityModel = [_cityList objectAtIndex:[self.cityTableView indexPathForSelectedRow].row];
        displayWeatherVC.selectedCity = selectedCityModel.cityName;
        
    }
}


#pragma mark - Button Actions

- (IBAction)getWeatherBtnTapped:(id)sender {
    
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:self.cityTextField.text,[NSNumber numberWithInt:3], nil] forKeys:[NSArray arrayWithObjects:@"searchText",@"numberOfDays",nil]];
    
    [serviceActivityIndicator startAnimating];
    
    [displayWeatherManager getAllCitiesWithName:requestDict success:^(NSDictionary *responseDict, NSInteger status) {
        
        NSArray *resultArray = [responseDict objectForKey:ServiceUSCityNames];
        NSLog(@"US Cities : %@", resultArray);
        self.cityList = resultArray;
        resultArray = nil;
        [self.cityTableView setHidden:NO];
        [self.cityTableView reloadData];
        [serviceActivityIndicator stopAnimating];
        
    } failureBlock:^(NSError *error, NSInteger status) {
        
        NSLog(@"Error :%@",error);
        self.cityList = nil;
        [self.cityTableView setHidden:NO];
        [self.cityTableView reloadData];
        [serviceActivityIndicator stopAnimating];
        
    }];
}


#pragma mark - Validation
-(BOOL)shouldEnableWeatherBtn:(NSString*)textFieldString{
    
    return textFieldString.length != 0 ? YES:NO;
}



@end
