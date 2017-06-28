//
//  WeatherAppTests.m
//  WeatherAppTests
//
//  Created by Dinesh Selvaraj on 6/26/17.
//  Copyright © 2017 Dinesh Selvaraj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DisplayWeatherManager.h"

@interface WeatherAppTests : XCTestCase
{
    DisplayWeatherManager *weatherDataMgr;
}
@end

@implementation WeatherAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    weatherDataMgr = [[DisplayWeatherManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testGetAllCities{
    
    __block NSCondition *completed = NSCondition.new;
    [completed lock];
    __weak typeof (self) weakSelf = self;

    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"-----",[NSNumber numberWithInt:3], nil] forKeys:[NSArray arrayWithObjects:@"searchText",@"numberOfDays",nil]];
    
    [weatherDataMgr getAllCitiesWithName:requestDict success:^(NSDictionary *responseDict, NSInteger status) {
        
        NSArray *resultArray = [responseDict objectForKey:ServiceUSCityNames];
        XCTAssertNotEqual([resultArray count], 0, @"There is some issue with webservice. The resukt shouldn't be empty for the proper city name");
        [weakSelf signalFinished:completed];
        
        
    } failureBlock:^(NSError *error, NSInteger status) {
        [weakSelf signalFinished:completed];
    }];
    
    [completed waitUntilDate:[NSDate distantFuture]];
    [completed unlock];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)signalFinished:(NSCondition *)condition
{
    [condition lock];
    [condition signal];
    [condition unlock];
}

@end
