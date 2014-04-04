simple-swipe-calendar
=====================

Simple calendar based on UICollectionView that requires swipes to switch between months.
Requires iOS >= 6.0.

To initialize a calendar viewcontroller use the method 
  KGCalendarSwipeViewController.h:- (id)initWithRelativeToSuperviewPosition:(CGPoint)position; , 
e.g.
  UIViewController *root = ...
   KGCalendarSwipeViewController *c = [[[KGCalendarSwipeViewController alloc] initWithRelativeToSuperviewPosition:CGPointMake(200, 200)] autorelease];
  [root.view addSubview:c.view];  

  

