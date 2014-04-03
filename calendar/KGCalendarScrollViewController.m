//
//  KGCalendarScrollViewController.m
//  calendar
//
//  Created by Catherine on 02/04/2014.
//
//

#import "KGCalendarScrollViewController.h"
#import "KGCalendarTableViewCell.h"

@interface KGCalendarScrollViewController ()

@end

@implementation KGCalendarScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

static GLfloat __tableRowHeight = 343.;
- (GLfloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return __tableRowHeight;
}

static NSString *__cellIdentifier = @"CalendarTableCellIdentifier";
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KGCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:__cellIdentifier];
    
    if (!cell) {
        UINib *cellNib = [UINib nibWithNibName:@"KGCalendarTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:cellNib forCellReuseIdentifier:__cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:__cellIdentifier];
    }
    
    [cell.calendar.view removeFromSuperview];
    cell.calendar = [[[KGCalendarViewController alloc] init] autorelease];
    [cell addSubview:cell.calendar.view];
    
    return cell;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    NSLog(@"done 1");
    
    if ((int)scrollView.contentOffset.y % (int)__tableRowHeight != 0) {
        
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));   
    NSLog(@"done 2");
    
    if ((int)scrollView.contentOffset.y % (int)__tableRowHeight != 0) {
        NSLog(@"should adjust");
    }
}


- (void)dealloc {

    [_table release];
    [super dealloc];
}
@end
