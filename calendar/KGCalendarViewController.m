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

@interface KGCalendarViewController ()

@end

@implementation KGCalendarViewController

@synthesize calendarSheet = _calendarSheet;

static NSString *__calendarCellReuseIdentifier = @"CalendarViewCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStatusBarOrientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_calendarSheet release];
    [_calendarView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubviewPositionsWithCurrentInterfaceOrientation];
    
    [self.calendarView registerClass:[KGCalendarViewCell class] forCellWithReuseIdentifier:__calendarCellReuseIdentifier];
    
    [self loadCalendarSheet];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadCalendarSheet {
    self.calendarSheet = [KGCalendarCore calendarSheetForCurrentMonth];
    _firstDayOffset = [KGCalendarCore firstDayOffsetForCurrentMonth];
}

#pragma mark - collection view data source implementation

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.calendarSheet.count + _firstDayOffset;
}

static BOOL __calendarCellNibLoaded = NO;
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!__calendarCellNibLoaded) {
        [self.calendarView registerNib:[UINib nibWithNibName:@"KGCalendarViewCell"
                                                      bundle:[NSBundle mainBundle]]
            forCellWithReuseIdentifier:__calendarCellReuseIdentifier];
        __calendarCellNibLoaded = YES;
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
