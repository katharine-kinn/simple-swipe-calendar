//
//  KGCalendarScrollViewController.h
//  calendar
//
//  Created by Catherine on 02/04/2014.
//
//

#import <UIKit/UIKit.h>

@interface KGCalendarScrollViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
}
@property (retain, nonatomic) IBOutlet UITableView *table;

@end
