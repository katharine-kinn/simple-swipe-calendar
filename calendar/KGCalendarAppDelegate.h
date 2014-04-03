//
//  KGCalendarAppDelegate.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <UIKit/UIKit.h>
#import "KGCalendarViewController.h"
#import "KGCalendarScrollViewController.h"
#import "KGCalendarSwipeViewController.h"

@interface KGCalendarAppDelegate : UIResponder <UIApplicationDelegate> {
    UIViewController *_rootViewController;
    KGCalendarViewController *_calendarViewController;
    KGCalendarScrollViewController *_calendalScrollViewController;
    KGCalendarSwipeViewController *_calendarSwipeViewController;
}

@property (nonatomic, retain) UIViewController *rootViewController;
@property (nonatomic, retain) KGCalendarViewController *calendarViewController;
@property (nonatomic, retain) KGCalendarScrollViewController *calendalScrollViewController;
@property (nonatomic, retain) KGCalendarSwipeViewController *calendarSwipeViewController;

@property (strong, nonatomic) UIWindow *window;

@end
