//
//  KGCalendarCore.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <Foundation/Foundation.h>

@interface KGCalendarCore : NSObject {
    // TODO: CACHE CURRENT MONTH!
}

+ (NSArray *) calendarSheetForMonth:(NSInteger)month year:(NSInteger)year;
+ (NSArray *) calendarSheetForCurrentMonth;

+ (int) firstDayOffsetForMonth:(NSInteger)month year:(NSInteger)year;
+ (int) firstDayOffsetForCurrentMonth;

+ (NSArray *) leapYearsFrom1970;

@end
