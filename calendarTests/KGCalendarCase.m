//
//  KGCalendarCase.m
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <XCTest/XCTest.h>
#import "KGCalendarCore.h"

@interface KGCalendarCase : XCTestCase

@end

@implementation KGCalendarCase

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testLeapYearsCount {
    NSArray *years = [KGCalendarCore leapYearsFrom1970];
    XCTAssertNotEqual(years.count, 0, @"No way leap years count can be 0");
}

- (void) testValidFebruaryDaysCountOnLeapYear {
    NSArray *sheet = [KGCalendarCore calendarSheetForMonth:2 year:2004];
    XCTAssertEqual(sheet.count, 29, @"Invalid February days count for leap year %d", 2004);
}

- (void) testValidFebruaryDaysCountOnLeapYearsSince1970 {
    NSArray *years = [KGCalendarCore leapYearsFrom1970];
    for (id year in years) {
        NSArray *sheet = [KGCalendarCore calendarSheetForMonth:2 year:[year intValue]];
        XCTAssertEqual(sheet.count, 29, @"Invalid February days count for leap year %d", [year intValue]);
    }
}

- (void) testValidFebruaryDaysCountOnNonLeapYear {
    
}

@end
