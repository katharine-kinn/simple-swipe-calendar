//
//  KGCalendarAppDelegate.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <UIKit/UIKit.h>
#import "KGCalendarViewController.h"

@interface KGCalendarAppDelegate : UIResponder <UIApplicationDelegate> {
    UIViewController *_rootViewController;
    KGCalendarViewController *_calendarViewController;
}

@property (nonatomic, retain) UIViewController *rootViewController;
@property (nonatomic, retain) KGCalendarViewController *calendarViewController;

@property (strong, nonatomic) UIWindow *window;

@end
