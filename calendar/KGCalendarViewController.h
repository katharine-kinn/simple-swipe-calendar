//
//  KGCalendarViewController.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <UIKit/UIKit.h>

@interface KGCalendarViewController : UIViewController<UICollectionViewDataSource> {
    NSArray *_calendarSheet;
    int _firstDayOffset;
}

@property (nonatomic, retain) NSArray *calendarSheet;

@property (retain, nonatomic) IBOutlet UICollectionView *calendarView;

@end
