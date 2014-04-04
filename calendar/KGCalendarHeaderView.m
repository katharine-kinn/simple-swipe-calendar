//
//  KGCalendarHeaderView.m
//  calendar
//
//  Created by Catherine on 04/04/2014.
//
//

#import "KGCalendarHeaderView.h"
#import "KGCalendarCore.h"

@implementation KGCalendarHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (CGRect) defaultBounds {
    return CGRectMake(0, 0, 294, 21);
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self setWeekdayLabels];
}

- (void) setWeekdayLabels {
    NSArray *names = [[KGCalendarCore sharedCalendarCore] localizedWeekdayNamesShort];
    for (int i = 0; i < MIN(names.count, self.weekdayLabels.count); ++i) {
        UILabel *label = [self.weekdayLabels objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [names objectAtIndex:i];
    }
}


- (void)dealloc {
    [_weekdayLabels release];
    [super dealloc];
}
@end
