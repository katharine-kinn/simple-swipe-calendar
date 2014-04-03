//
//  KGCalendarTableViewCell.h
//  calendar
//
//  Created by Catherine on 02/04/2014.
//
//

#import <UIKit/UIKit.h>
#import "KGCalendarViewController.h"

@interface KGCalendarTableViewCell : UITableViewCell {
    KGCalendarViewController *_calendar;
}

@property (nonatomic, retain) KGCalendarViewController *calendar;

@end
