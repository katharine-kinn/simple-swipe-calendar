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
}

+ (KGCalendarCore *) sharedCalendarCore;

- (NSArray *) calendarSheetForMonth:(NSInteger)month year:(NSInteger)year;
- (int) firstDayOffsetForMonth:(NSInteger)month year:(NSInteger)year;

- (NSString *) localizedMonthName:(NSInteger)month;

- (NSDateComponents *) getTodayDateComponents;


@end
