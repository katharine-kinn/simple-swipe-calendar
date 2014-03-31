//
//  KGCalendarCore.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <Foundation/Foundation.h>

@interface KGCalendarCore : NSObject

+ (NSArray *) calendarSheetForMonth:(NSInteger)month year:(NSInteger)year;

+ (NSArray *) leapYearsFrom1970;

@end
