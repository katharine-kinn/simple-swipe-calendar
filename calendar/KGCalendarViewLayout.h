//
//  KGCalendarViewLayout.h
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import <UIKit/UIKit.h>

@interface KGCalendarViewLayout : UICollectionViewLayout {
    int _rows;
    int _columns;
    int _cellSide;
    
    NSMutableDictionary *_layoutInfo;
}

@property (nonatomic, assign) int rows;
@property (nonatomic, assign) int columns;
@property (nonatomic, assign) int cellSide;
@property (nonatomic, retain) NSMutableDictionary *layoutInfo;

@end
