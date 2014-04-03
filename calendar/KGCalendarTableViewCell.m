//
//  KGCalendarTableViewCell.m
//  calendar
//
//  Created by Catherine on 02/04/2014.
//
//

#import "KGCalendarTableViewCell.h"

@implementation KGCalendarTableViewCell

@synthesize calendar = _calendar;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) dealloc {
    self.calendar = nil;
    [super dealloc];
}

@end
