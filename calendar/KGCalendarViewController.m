//
//  KGCalendarViewController.m
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import "KGCalendarViewController.h"
#import "KGCalendarCore.h"
#import "KGCalendarViewCell.h"
#import "KGCalendarViewLayout.h"

@interface KGCalendarViewController ()

@end

@implementation KGCalendarViewController

@synthesize calendarSheet = _calendarSheet;
@synthesize currentYear = _currentYear;
@synthesize currentMonth = _currentMonth;
@synthesize delegate = _delegate;

static NSString *__calendarCellReuseIdentifier = @"CalendarViewCell";

- (id) initWithMonth:(NSInteger)month year:(NSInteger)year delegate:(NSObject<KGCalendarViewControllerDelegate> *)delegate {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.delegate = delegate;
        _currentMonth = month;
        _currentYear = year;
//        [self setupCurrentDateWithMonth:month year:year];
    }
    return self;
}

- (id) initWithMonth:(NSInteger)month year:(NSInteger)year {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.delegate = nil;
        _currentMonth = month;
        _currentYear = year;
//        [self setupCurrentDateWithMonth:month year:year];
    }
    return self;
}

- (id) initWithTodayWithDelegate:(NSObject<KGCalendarViewControllerDelegate> *)delegate {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.delegate = delegate;
        NSDateComponents *dateComponents = [[KGCalendarCore sharedCalendarCore] getTodayDateComponents];
        _currentMonth = dateComponents.month;
        _currentYear = dateComponents.year;
//        [self setupCurrentDateWithMonth:dateComponents.month year:dateComponents.year];
    }
    return self;
}

- (id) initWithToday {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.delegate = nil;
        NSDateComponents *dateComponents = [[KGCalendarCore sharedCalendarCore] getTodayDateComponents];
        _currentMonth = dateComponents.month;
        _currentYear = dateComponents.year;
//        [self setupCurrentDateWithMonth:dateComponents.month year:dateComponents.year];
    }
    return self;
}

- (void) setupCurrentDateWithMonth:(NSInteger)month year:(NSInteger)year {
    self.currentMonth = month;
    self.currentYear = year;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_calendarSheet release];
    [_calendarView release];
    [_monthLabel release];
    [_yearLabel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    _cellNibLoaded = NO;
    
    [super viewDidLoad];

    [self.calendarView registerClass:[KGCalendarViewCell class] forCellWithReuseIdentifier:__calendarCellReuseIdentifier];
    
    NSInteger month = self.currentMonth;
    _currentMonth = 0;
    
    NSInteger year = self.currentYear;
    _currentYear = 0;
    
    [self setupCurrentDateWithMonth:month year:year];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data reload

- (void) loadCalendarSheet {
    
    self.calendarSheet = [[KGCalendarCore sharedCalendarCore] calendarSheetForMonth:self.currentMonth year:self.currentYear];
    _firstDayOffset = [[KGCalendarCore sharedCalendarCore] firstDayOffsetForMonth:self.currentMonth year:self.currentMonth];

}

- (void) setMonthLabelTextWithMonth:(NSInteger)month {
    [self.monthLabel setText:[[KGCalendarCore sharedCalendarCore] localizedMonthName:month]];
}

- (void) setYearLabelTextWithYear:(NSInteger)year {
    [self.yearLabel setText:[NSString stringWithFormat:@"%d", (int)year]];
}

#pragma mark - collection view data source implementation

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.calendarSheet.count + _firstDayOffset;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_cellNibLoaded) {
        [self.calendarView registerNib:[UINib nibWithNibName:@"KGCalendarViewCell"
                                                      bundle:[NSBundle mainBundle]]
            forCellWithReuseIdentifier:__calendarCellReuseIdentifier];
        _cellNibLoaded = YES;
    }
    
    KGCalendarViewCell *cell = [self.calendarView dequeueReusableCellWithReuseIdentifier:__calendarCellReuseIdentifier forIndexPath:indexPath];
    cell.dayLabel.text = @"";
    
    for (int i = 0; i < self.calendarSheet.count; ++i) {
        NSDictionary *dayDict = [self.calendarSheet objectAtIndex:i];
        int day = [[dayDict objectForKey:@"day"] intValue];
        
        if (day - 1 + _firstDayOffset == indexPath.row) {
            cell.dayLabel.text = [NSString stringWithFormat:@"%d", day];
            break;
        }
    }
    
    return cell;
}

#pragma mark - display sheet logic

static int __monthsMax = 12;

- (NSInteger) getCurrentMonth {
    return _currentMonth;
}

- (NSInteger) getCurrentYear {
    return _currentYear;
}

- (void) setCurrentMonth:(NSInteger)currentMonth {
    
    NSAssert(currentMonth >= 0, @"Month cannot be negative");
    
    if (_currentMonth != currentMonth) {
        
        NSInteger oldMonth = _currentMonth;
        NSInteger oldYear = _currentYear;
        
        if (currentMonth > __monthsMax) {
            currentMonth = 1;
            [self setCurrentYear:oldYear + 1 shouldUpdateViewAndDelegate:NO];
        } else if (currentMonth == 0) {
            currentMonth = __monthsMax;
            [self setCurrentYear:oldYear - 1 shouldUpdateViewAndDelegate:NO];
        }
        
        _currentMonth = currentMonth;
        [self setMonthLabelTextWithMonth:_currentMonth];
        
        dispatch_async(dispatch_get_main_queue(), ^(){

            [self loadCalendarSheet];
            [self.calendarView reloadData];
            
            if (self.delegate) {
                [KGCalendarCore sharedCalendarCore].currentMonthDaysCount = self.calendarSheet.count;
                [KGCalendarCore sharedCalendarCore].currentFirstMonthDayOffset = _firstDayOffset;
            }

        });
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            KGCalendarViewLayout *layout = [[[KGCalendarViewLayout alloc] init] autorelease];
            [self.calendarView setCollectionViewLayout:layout animated:NO];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            if (self.delegate) {
                [self.delegate onMonthChanged:oldMonth];
            }
            
            if (oldYear != _currentYear) {
                [self.delegate onYearChanged:oldYear];
            }
        });
    
    }
    
}

- (void) setCurrentYear:(NSInteger)currentYear shouldUpdateViewAndDelegate:(BOOL)shouldUpdateViewAndDelegate {
    NSAssert(currentYear >= 0, @"Year cannot be negative");
    
    if (_currentYear != currentYear) {
        NSInteger oldYear = _currentYear;
        _currentYear = currentYear;
        [self setYearLabelTextWithYear:_currentYear];
        
        if (shouldUpdateViewAndDelegate) {
            
            dispatch_async(dispatch_get_main_queue(), ^() {
                [self loadCalendarSheet];
                [self.calendarView reloadData];
                
                if (self.delegate) {
                    [KGCalendarCore sharedCalendarCore].currentMonthDaysCount = self.calendarSheet.count;
                    [KGCalendarCore sharedCalendarCore].currentFirstMonthDayOffset = _firstDayOffset;
                }
            });
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                KGCalendarViewLayout *layout = [[[KGCalendarViewLayout alloc] init] autorelease];
                [self.calendarView setCollectionViewLayout:layout animated:NO];
            });
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                if (self.delegate) {
                    [self.delegate onYearChanged:oldYear];
                }
            });
        }

    }
}

- (void) setCurrentYear:(NSInteger)currentYear {

    [self setCurrentYear:currentYear shouldUpdateViewAndDelegate:YES];
    
}


#pragma mark - status bar orientation

- (void) onStatusBarOrientationChanged:(NSNotification *)notification {
    [self setupSubviewPositionsWithCurrentInterfaceOrientation];
}

- (void) setupSubviewPositionsWithCurrentInterfaceOrientation {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self setupSubviewPositionsWithInterfaceOrientation:orientation];
}

- (void) setupSubviewPositionsWithInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    float width = 0;
    float height = 0;
    float parentWidth = 0;
    float parentHeight = 0;
    
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (currentOrientation == UIInterfaceOrientationLandscapeLeft || currentOrientation == UIInterfaceOrientationLandscapeRight) {
        width = self.view.frame.size.width;
        parentWidth = applicationFrame.size.height;
        height = self.view.frame.size.height;
        parentHeight = applicationFrame.size.width;
    }
    
    if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        width = self.view.frame.size.height;
        parentWidth = applicationFrame.size.width;
        height = self.view.frame.size.width;
        parentHeight = applicationFrame.size.height;
    }
    
    [self.view setFrame:CGRectMake((parentWidth - width) / 2,
                                   (parentHeight - height) / 2,
                                   width,
                                   height)];
}

@end
