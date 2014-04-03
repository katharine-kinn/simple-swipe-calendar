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
    
    NSInteger _currentMonthDaysCount;
    NSInteger _currentFirstMonthDayOffset;
}

@property (nonatomic, assign) NSInteger currentMonthDaysCount;
@property (nonatomic, assign) NSInteger currentFirstMonthDayOffset;

+ (KGCalendarCore *) sharedCalendarCore;

- (NSArray *) calendarSheetForMonth:(NSInteger)month year:(NSInteger)year;
- (int) firstDayOffsetForMonth:(NSInteger)month year:(NSInteger)year;

- (NSDateComponents *) getTodayDateComponents;


@end
