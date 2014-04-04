//
//  KGCalendarCore.m
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import "KGCalendarCore.h"

@interface KGCalendarCore (Private)

@end

@implementation KGCalendarCore



static KGCalendarCore *__instance = nil;
+ (KGCalendarCore *) sharedCalendarCore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[KGCalendarCore alloc] init];
    });
    return __instance;
}

- (id) init {
    if (self = [super init]) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        _calendar.firstWeekday = 2;
    }
    return self;
}

- (void) dealloc {
    [_calendar release];
    [super dealloc];
}

- (NSArray *) calendarSheetForMonth:(NSInteger)month year:(NSInteger)year {
    
    NSMutableArray *sheet = nil;
    
    NSDateComponents *anchorDateComponents = [[NSDateComponents alloc] init];
    [anchorDateComponents setCalendar:_calendar];
    [anchorDateComponents setMonth:month];
    [anchorDateComponents setYear:year];
    [anchorDateComponents setDay:1];
    
    NSDate *anchorDate = [anchorDateComponents date];
    NSRange daysInMonthRange = [_calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:anchorDate];
    int daysInMonth = 0;
    
    [anchorDateComponents release];
    
    if (daysInMonthRange.location != NSNotFound) {
        daysInMonth = daysInMonthRange.length;
        
        sheet = [NSMutableArray array];
        
        for (int i = 0; i < daysInMonth; ++i) {
            int day = i + 1;
            
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setCalendar:_calendar];
            [dateComponents setMonth:month];
            [dateComponents setYear:year];
            [dateComponents setDay:day];
            
            NSDate *date = [dateComponents date];
            NSInteger weekday = [_calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
            
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

    return sheet;

}

- (int) firstDayOffsetForMonth:(NSInteger)month year:(NSInteger)year {
    int offset = 0;
    
    NSArray *sheet = [self calendarSheetForMonth:month year:year];
    NSDictionary *firstDayDict = [sheet objectAtIndex:0];
    int firstWeekday = [[firstDayDict objectForKey:@"weekday"] intValue];
    offset = firstWeekday - 1;
    
    return offset;
}

- (NSDateComponents *) getTodayDateComponents {
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [_calendar components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    return dateComponents;
}

- (NSString *) localizedMonthName:(NSInteger)month {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:_calendar];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSString *name = [[dateFormatter monthSymbols] objectAtIndex:month - 1];
    [dateFormatter release];
    return name;
}

- (NSArray *) localizedWeekdayNamesShort {
    NSMutableArray *weekdayNames = [NSMutableArray array];
    
    for (int i = 0; i < 7; ++i) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setCalendar:_calendar];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        
        NSString *name = [[dateFormatter shortWeekdaySymbols] objectAtIndex:i];
        [dateFormatter release];
        [weekdayNames addObject:name];
    }
    
    return weekdayNames;
}


@end
