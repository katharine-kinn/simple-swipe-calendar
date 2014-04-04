//
//  KGCalendarSwipeViewController.m
//  calendar
//
//  Created by Catherine on 02/04/2014.
//
//

#import "KGCalendarSwipeViewController.h"
#import "KGCalendarCore.h"

@interface KGCalendarSwipeViewController ()

@end

@implementation KGCalendarSwipeViewController

- (id)initWithRelativeToSuperviewPosition:(CGPoint)position
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _position = position;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect frame = CGRectMake(_position.x, _position.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view setFrame:frame];
    
    self.calendar = [[[KGCalendarViewController alloc] initWithTodayWithDelegate:self] autorelease];
    [self.calendarContentView addSubview:self.calendar.view];
    
    [self setupSwipeRecognizers];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMonthChanged:) name:KGCalendarCurrentMonthChanged object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onYearChanged:) name:KGCalendarCurrentYearChanged object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void) handleLeftSwipeGesture:(UISwipeGestureRecognizer *)recognizer {
    self.oldCalendar = [[[KGCalendarViewController alloc] initWithMonth:self.calendar.currentMonth year:self.calendar.currentYear] autorelease];
    [self.calendarContentView addSubview:self.oldCalendar.view];
    [self.calendar.view removeFromSuperview];
    self.calendar.currentMonth++;
}

- (void) handleRightSwipeGesture:(UISwipeGestureRecognizer *)recognizer {
    self.oldCalendar = [[[KGCalendarViewController alloc] initWithMonth:self.calendar.currentMonth year:self.calendar.currentYear] autorelease];
    [self.calendarContentView addSubview:self.oldCalendar.view];
    [self.calendar.view removeFromSuperview];
    self.calendar.currentMonth--;
}

- (void) setupSwipeRecognizers {
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeGesture:)] autorelease];
    [leftSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipeRecognizer];
    
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeGesture:)] autorelease];
    [rightSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipeRecognizer];
}

- (void) onMonthChanged:(NSInteger)oldMonth {
    
    int direction = 0;
    
    if (oldMonth < self.calendar.currentMonth) {
        direction = -1;
    } else {
        direction = 1;
    }
    
    if (self.oldCalendar) {
        if (self.oldCalendar.currentYear > self.calendar.currentYear && self.oldCalendar.currentMonth < self.calendar.currentMonth) {
            direction = 1;
        } else if (self.oldCalendar.currentYear < self.calendar.currentYear && self.oldCalendar.currentMonth > self.calendar.currentMonth) {
            direction = -1;
        }
    }

    
    CGFloat x = self.oldCalendar.view.frame.origin.x;
    CGFloat y = self.oldCalendar.view.frame.origin.y;
    CGFloat width = self.calendar.view.frame.size.width;
    CGFloat height = self.calendar.view.frame.size.height;
    
    CGRect newCalendarFrame = CGRectMake(x - direction * width, y, width, height);
    [self.calendar.view setFrame:newCalendarFrame];
    [self.calendarContentView addSubview:self.calendar.view];
    
    [UIView animateWithDuration:0.3
                     animations:^(){
                         
                         CGRect oldCalendarFrame = CGRectMake(x + direction * width, y, width, height);
                         [self.oldCalendar.view setFrame:oldCalendarFrame];
                         
                         CGRect calendarFrame = CGRectMake(x, y, width, height);
                         [self.calendar.view setFrame:calendarFrame];
                         

                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [self.oldCalendar.view removeFromSuperview];
                             self.oldCalendar = nil;
                         }

                     }];
    
}

- (void) onYearChanged:(NSInteger)oldYear {
    
}

- (void) dealloc {
    self.calendar = nil;
    self.oldCalendar = nil;
    [_calendarContentView release];
    [super dealloc];
}

@end
