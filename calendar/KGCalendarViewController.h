//
//  KGCalendarViewController.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <UIKit/UIKit.h>

@interface KGCalendarViewController : UIViewController<UICollectionViewDataSource>
@property (retain, nonatomic) IBOutlet UICollectionView *calendarView;

@end
