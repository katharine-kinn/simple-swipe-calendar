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

- (void) testMonthsFlow {
    for (int i = -1; i <= 13; ++i) {
        [KGCalendarCore sharedCalendarCore].currentMonth = i;
        XCTAssertTrue([KGCalendarCore sharedCalendarCore].currentMonth >= 1 && [KGCalendarCore sharedCalendarCore].currentMonth <= 12, @"invalid month for i = %d", i);
    }
}

@end
