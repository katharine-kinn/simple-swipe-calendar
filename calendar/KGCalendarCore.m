//
//  KGCalendarCore.m
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import "KGCalendarCore.h"

@interface KGCalendarCore (Private)
- (NSArray *) calendarSheetForMonth:(NSInteger)month year:(NSInteger)year;
- (int) firstDayOffsetForMonth:(NSInteger)month year:(NSInteger)year;
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
        self.currentMonth = -1;
        self.currentYear = -1;
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

- (NSArray *) calendarSheetForCurrentMonth {
    NSArray *sheet = [self calendarSheetForMonth:self.currentMonth year:self.currentYear];
    return sheet;
}

- (NSArray *) calendarSheetForToday {
    NSDateComponents *dateComponents = [self getTodayDateComponents];
    NSArray *sheet = [self calendarSheetForMonth:dateComponents.month year:dateComponents.year];
    return sheet;
}

#pragma mark -

static int __monthsMax = 12;

- (NSInteger) getCurrentMonth {
    return _currentMonth;
}

- (NSInteger) getCurrentYear {
    return _currentYear;
}

- (void) setCurrentMonth:(NSInteger)currentMonth {
    
    NSInteger oldMonth = _currentMonth;
    
    if (currentMonth < 0) {
        [self setTodayMonthAsCurrent];
    } else {
        if (currentMonth > __monthsMax) {
            currentMonth = 1;
            self.currentYear++;
        } else if (currentMonth == 0) {
            currentMonth = __monthsMax;
            self.currentYear--;
        }
        
        _currentMonth = currentMonth;
    }
    
    if (_currentMonth != oldMonth) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KGCalendarCurrentMonthChanged object:nil];
    }
    
}

- (void) setCurrentYear:(NSInteger)currentYear {
    
    NSInteger oldYear = _currentYear;
    
    if (currentYear < 0) {
        [self setTodayYearAsCurrent];
    } else {
        _currentYear = currentYear;
    }
    
    if (_currentYear != oldYear) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KGCalendarCurrentYearChanged object:nil];
    }
    
}

- (void) setTodayMonthAsCurrent {
    NSDateComponents *dateComponents = [self getTodayDateComponents];
    _currentMonth = dateComponents.month;
}

- (void) setTodayYearAsCurrent {
    NSDateComponents *dateComponents = [self getTodayDateComponents];
    _currentYear = dateComponents.year;
}

- (NSDateComponents *) getTodayDateComponents {
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [_calendar components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    return dateComponents;
}

#pragma mark - first day offset

- (int) firstDayOffsetForMonth:(NSInteger)month year:(NSInteger)year {
    int offset = 0;
    
    NSArray *sheet = [self calendarSheetForMonth:month year:year];
    NSDictionary *firstDayDict = [sheet objectAtIndex:0];
    int firstWeekday = [[firstDayDict objectForKey:@"weekday"] intValue];
    offset = firstWeekday - 1;
    
    return offset;
}

- (int) firstDayOffsetForCurrentMonth {
    int offset = [self firstDayOffsetForMonth:self.currentMonth year:self.currentYear];
    return offset;
}


@end
