//
//  KGCalendarSwipeViewController.h
//  calendar
//
//  Created by Catherine on 02/04/2014.
//
//

#import <UIKit/UIKit.h>
#import "KGCalendarViewController.h"

@interface KGCalendarSwipeViewController : UIViewController<KGCalendarViewControllerDelegate> {
    KGCalendarViewController *_calendar;
    KGCalendarViewController *_oldCalendar;
    CGPoint _position;
}

@property (nonatomic, retain) KGCalendarViewController *calendar;
@property (nonatomic, retain) KGCalendarViewController *oldCalendar;

@property (retain, nonatomic) IBOutlet UIView *calendarContentView;

- (id) initWithRelativeToSuperviewPosition:(CGPoint)position;

@end
