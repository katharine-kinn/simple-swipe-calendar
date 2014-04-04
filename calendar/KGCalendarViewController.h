//
//  KGCalendarViewController.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <UIKit/UIKit.h>

@protocol KGCalendarViewControllerDelegate <NSObject>

- (void) onMonthChanged:(NSInteger)oldMonth;
- (void) onYearChanged:(NSInteger)oldYear;

@end

@interface KGCalendarViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate> {
    NSArray *_calendarSheet;
    int _firstDayOffset;
    NSInteger _currentMonth;
    NSInteger _currentYear;
    
    NSObject<KGCalendarViewControllerDelegate> *_delegate;
    
    BOOL _cellNibLoaded;
}

@property (nonatomic, assign, getter = getCurrentMonth, setter = setCurrentMonth:) NSInteger currentMonth;
@property (nonatomic, assign, getter = getCurrentYear, setter = setCurrentYear:) NSInteger currentYear;
@property (nonatomic, assign) int firstDayOffset;
@property (nonatomic, assign) NSObject<KGCalendarViewControllerDelegate> *delegate;
@property (nonatomic, retain) NSArray *calendarSheet;

@property (retain, nonatomic) IBOutlet UICollectionView *calendarView;
@property (retain, nonatomic) IBOutlet UILabel *monthLabel;
@property (retain, nonatomic) IBOutlet UILabel *yearLabel;

- (id) initWithMonth:(NSInteger)month year:(NSInteger)year delegate:(NSObject<KGCalendarViewControllerDelegate> *)delegate;
- (id) initWithTodayWithDelegate:(NSObject<KGCalendarViewControllerDelegate> *)delegate;

- (id) initWithMonth:(NSInteger)month year:(NSInteger)year;
- (id) initWithToday;

@end
