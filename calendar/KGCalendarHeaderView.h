//
//  KGCalendarHeaderView.h
//  calendar
//
//  Created by Catherine on 04/04/2014.
//
//

#import <UIKit/UIKit.h>

@interface KGCalendarHeaderView : UICollectionReusableView {
    
}

@property (retain, nonatomic) IBOutletCollection(UILabel) NSArray *weekdayLabels;

+ (CGRect) defaultBounds;

- (void) setWeekdayLabels;

@end
