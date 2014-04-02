//
//  KGCalendarCore.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <Foundation/Foundation.h>

#define KGCalendarCurrentMonthChanged @"KGCalendarCurrentMonthChanged"
#define KGCalendarCurrentYearChanged @"KGCalendarCurrentYearChanged"

@interface KGCalendarCore : NSObject {
    NSCalendar *_calendar;
    NSInteger _currentMonth;
    NSInteger _currentYear;
}

@property (nonatomic, assign, getter = getCurrentMonth, setter = setCurrentMonth:) NSInteger currentMonth;
@property (nonatomic, assign, getter = getCurrentYear, setter = setCurrentYear:) NSInteger currentYear;

+ (KGCalendarCore *) sharedCalendarCore;

- (NSArray *) calendarSheetForCurrentMonth;
- (NSArray *) calendarSheetForToday;

- (int) firstDayOffsetForCurrentMonth;

//+ (NSArray *) leapYearsFrom1970;

@end
