//
//  KGCalendarAppDelegate.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <UIKit/UIKit.h>
#import "KGCalendarSwipeViewController.h"

@interface KGCalendarAppDelegate : UIResponder <UIApplicationDelegate> {
    UIViewController *_rootViewController;
    KGCalendarSwipeViewController *_calendarSwipeViewController;
}

@property (nonatomic, retain) UIViewController *rootViewController;
@property (nonatomic, retain) KGCalendarSwipeViewController *calendarSwipeViewController;

@property (strong, nonatomic) UIWindow *window;

@end
