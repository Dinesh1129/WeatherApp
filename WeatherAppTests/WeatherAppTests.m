//
//  WeatherAppTests.m
//  WeatherAppTests
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GMDisplayWeatherManager.h"
#import "GMCommonUtility.h"

#import "DateModel.h"
#import "ForecastDayModel.h"

#import "GMSelectCityVC.h"
#import "GMDisplayWeatherVC.h"
#import "GMDisplayWeatherCustomCell.h"

@interface WeatherAppTests : XCTestCase
{
    GMSelectCityVC *selectCityVC;
    GMDisplayWeatherVC *displayWeatherVC;
    GMDisplayWeatherCustomCell *customCell;
}
@end

@interface GMSelectCityVC (Tests)

-(BOOL)shouldEnableWeatherBtn:(NSString*)textFieldString;

@end

@implementation WeatherAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    selectCityVC = [storyBoard instantiateViewControllerWithIdentifier:@"SelectCityVC"];
    [selectCityVC view]; //Load view incase view is not loaded already
    
    displayWeatherVC = [storyBoard instantiateViewControllerWithIdentifier:@"DisplayWeatherVC"];
    displayWeatherVC.selectedCity = @"West Albany";
    [displayWeatherVC view]; //Load view incase view is not loaded already
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    selectCityVC = nil;
    displayWeatherVC = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


- (void)testShouldEnableDoneButton{
    XCTAssertEqual([selectCityVC shouldEnableWeatherBtn:@"   "], NO, @"Done button should be disabled for empty string");
    XCTAssertEqual([selectCityVC shouldEnableWeatherBtn:@"Charlotte"], YES, @"Done button should be enabled when the string length is greater than zero");

}

- (void)testDoneButtonStatus{
    
    //Deleting last character
    selectCityVC.cityTextField.text = @"a";
    [selectCityVC textField:selectCityVC.cityTextField shouldChangeCharactersInRange:NSMakeRange(0, 1) replacementString:@""];
    XCTAssertEqual(selectCityVC.getWeatherBtn.enabled, FALSE, @"Button should be disabled");
    
    //Deleting empty space
    selectCityVC.cityTextField.text = @"       ";
    [selectCityVC textField:selectCityVC.cityTextField shouldChangeCharactersInRange:NSMakeRange(6, 1) replacementString:@""];
    XCTAssertEqual(selectCityVC.getWeatherBtn.enabled, FALSE, @"Button should be disabled");
    
    //Deleting one charatcer
    selectCityVC.cityTextField.text = @"ab";
    [selectCityVC textField:selectCityVC.cityTextField shouldChangeCharactersInRange:NSMakeRange(1, 1) replacementString:@""];
    XCTAssertEqual(selectCityVC.getWeatherBtn.enabled, TRUE, @"Button should be enabled");
    
    
    //Text field should clear
    selectCityVC.cityTextField.text = @"Charlotte";
    [selectCityVC textFieldShouldClear:selectCityVC.cityTextField];
    XCTAssertEqual(selectCityVC.getWeatherBtn.enabled, FALSE, @"Button should be disabled");
    
}

- (void)testOnViewDidLoad{
    
    if([selectCityVC.activityIndicatorView isAnimating]){
        XCTFail(@"Activity Indicator should not be animating during initial load");
    }
    
    if(![selectCityVC.cityTableView isHidden]){
        XCTFail(@"Table view should be hidded during initial load");
    }
    
    if(selectCityVC.cityTextField.text.length != 0){
        XCTFail(@"Text field should not contain any text during initial load");
    }
}

- (void)testDisplayWeatherCustomCell{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting to make service call"];
    
    
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"West Albany, New York",[NSNumber numberWithInt:3], nil] forKeys:[NSArray arrayWithObjects:@"selectedCity",@"numberOfDays",nil]];
    
    [GMDisplayWeatherManager getWeatherForecastForTheCity:requestDict success:^(NSDictionary *responseDict, NSInteger status) {
        
        
        
        customCell = [displayWeatherVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSArray *weatherData = [responseDict objectForKey:ServiceWeatherRecord];
        [customCell updateUIWithModel:[weatherData firstObject]];
        
        ForecastDayModel *dayModel = [weatherData firstObject];
        
        DateModel *date = dayModel.date;
        
        XCTAssertEqual(customCell.dateLabel.text, date.pretty, @"Date is wrongly rendered");
        XCTAssertEqual(customCell.conditionLabel.text, dayModel.conditions,@"Conditon is wrongly rendered");
        [expectation fulfill];
        
    } failureBlock:^(NSError *error, NSInteger status) {
        if(error!=nil){
            XCTFail(@"Error is %@",error.localizedDescription);
        }
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        
    }];
    
}

- (void)testCreatePathParamForCity{
    NSString *city = @"Charlotte, North Carolina";
    NSString *formattedCity = [GMCommonUtility createPathParamForCity:city];
    
    NSRange range = [formattedCity rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    XCTAssertNotNil(formattedCity, @"Formatted value shouldn't be nil");
    XCTAssertEqual(range.length, 0, @"There should not be any white spaces in formatted city");
}

- (void)testGetAllCities{

    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting to make service call"];
    
    
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"Charlotte", nil] forKeys:[NSArray arrayWithObjects:@"searchText",nil]];
    
    [GMDisplayWeatherManager getAllCitiesWithName:requestDict success:^(NSDictionary *responseDict, NSInteger status) {
        
        NSArray *resultArray = [responseDict objectForKey:ServiceUSCityNames];
        XCTAssertNotNil(responseDict, @"Response Object should not be nil");
        XCTAssertNotEqual([resultArray count], 0, @"Data should not be nil");
        XCTAssertEqual(status, 200, @"Status should be 200");
        [expectation fulfill];
        
    } failureBlock:^(NSError *error, NSInteger status) {
        if(error!=nil){
            XCTFail(@"Error is %@",error.localizedDescription);
        }
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        
    }];
    
}

- (void)testGetWeatherForecast{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting to make service call"];

    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"West Albany, New York",[NSNumber numberWithInt:3], nil] forKeys:[NSArray arrayWithObjects:@"selectedCity",@"numberOfDays",nil]];
    
    [GMDisplayWeatherManager getWeatherForecastForTheCity:requestDict success:^(NSDictionary *responseDict, NSInteger status) {
        XCTAssertNotNil(responseDict, @"Response Object should not be nil");
        NSArray *weatherData = [responseDict objectForKey:ServiceWeatherRecord];
        XCTAssertNotNil(weatherData, @"Response Object should not be nil");
        XCTAssertEqual([weatherData count], 3, @"The filtered count should be 3");
        [expectation fulfill];

    } failureBlock:^(NSError *error, NSInteger status) {
        if(error!=nil){
            XCTFail(@"Error is %@",error.localizedDescription);
        }
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testFailureScenario{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting to make service call"];
    [GMServiceClient call:@"http://api.wunderground.com/api/59641563fdf5ea17/invalidString" success:^(id responseObject, NSInteger status) {
        XCTAssertEqual(status, 200, @"Success should always throw 200");
        [expectation fulfill];
    } failure:^(NSError *error, NSInteger status) {
        XCTAssertEqual(status, 500, @"Invalid URL should throw 500");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
