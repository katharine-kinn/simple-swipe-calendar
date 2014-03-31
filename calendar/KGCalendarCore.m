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
    NSMutableArray *sheet = [NSMutableArray array];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
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
