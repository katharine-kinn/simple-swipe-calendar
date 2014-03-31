//
//  KGCalendarCore.m
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import "KGCalendarCore.h"

//static int[12] __daysMonthAmount = {
//    
//};

@implementation KGCalendarCore

+ (NSArray *) calendarSheetForMonth:(NSInteger)month year:(NSInteger)year {
    NSMutableArray *sheet = nil;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.firstWeekday = 2;
    
    NSDateComponents *anchorDateComponents = [[NSDateComponents alloc] init];
    [anchorDateComponents setCalendar:calendar];
    [anchorDateComponents setMonth:month];
    [anchorDateComponents setYear:year];
    [anchorDateComponents setDay:1];
    
    NSDate *anchorDate = [anchorDateComponents date];
    NSRange daysInMonthRange = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:anchorDate];
    int daysInMonth = 0;
    
    [anchorDateComponents release];
    
    if (daysInMonthRange.location != NSNotFound) {
        daysInMonth = daysInMonthRange.length;
        
        sheet = [NSMutableArray array];
        
        for (int i = 0; i < daysInMonth; ++i) {
            int day = i + 1;
            
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setCalendar:calendar];
            [dateComponents setMonth:month];
            [dateComponents setYear:year];
            [dateComponents setDay:day];
            
            NSDate *date = [dateComponents date];
            NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:date];
            int weekday = [weekdayComponents weekday];
            weekday = [calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
            
            NSMutableDictionary *dateDict = [[NSMutableDictionary alloc] init];
            [dateDict setObject:@(weekday) forKey:@"weekday"];
            [dateDict setObject:@(day) forKey:@"day"];
            [dateDict setObject:@(month) forKey:@"month"];
            [dateDict setObject:@(year) forKey:@"year"];
            
            [sheet addObject:dateDict];
            
            [dateDict release];
            [dateComponents release];
        }
    } else {
        
    }

    [calendar release];
    
    return sheet;
}

+ (NSArray *) calendarSheetForCurrentMonth {
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [calendar components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    return [self calendarSheetForMonth:dateComponents.month year:dateComponents.year];
}

+ (int) firstDayOffsetForMonth:(NSInteger)month year:(NSInteger)year {
    int offset = 0;
    
    NSArray *sheet = [KGCalendarCore calendarSheetForMonth:month year:year];
    NSDictionary *firstDayDict = [sheet objectAtIndex:0];
    int firstWeekday = [[firstDayDict objectForKey:@"weekday"] intValue];
    offset = firstWeekday - 1;
    
    return offset;
}

+ (int) firstDayOffsetForCurrentMonth {
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [calendar components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    int offset = [self firstDayOffsetForMonth:dateComponents.month year:dateComponents.year];
    return offset;
}

+ (NSArray *) leapYearsFrom1970 {
    NSMutableArray *years = [NSMutableArray array];
    
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    int startYear = 1970;
    int currentYear = [[calendar components:NSCalendarUnitYear fromDate:[NSDate date]] year];
    
    for (int i = startYear; i < currentYear; i++) {
        if ((i % 4 == 0 && i % 100 != 0) || (i % 400 == 0)) {
            [years addObject:@(i)];
        }
    }
    
    return years;
}

@end
