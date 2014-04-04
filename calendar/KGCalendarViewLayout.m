//
//  KGCalendarViewLayout.m
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import "KGCalendarViewLayout.h"
#import "KGCalendarCore.h"
#import "KGCalendarViewController.h"
#import "KGCalendarHeaderView.h"

@implementation KGCalendarViewLayout

- (id) init {
    if ((self = [super init])) {
        _headerNibLoaded = NO;
        self.layoutInfo = [[[NSMutableDictionary alloc] init] autorelease];
        [self setup];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        _headerNibLoaded = NO;
        self.layoutInfo = [[[NSMutableDictionary alloc] init] autorelease];
        [self setup];
    }
    return self;
}

- (void) dealloc {
    self.layoutInfo = nil;
    [super dealloc];
}

static NSString *__calendarHeaderKind = @"CalendarHeader";
- (void) setup {
    self.columns = 7;
    self.cellSide = 42;
    [self registerClass:[KGCalendarHeaderView class] forDecorationViewOfKind:__calendarHeaderKind];
    if (!_headerNibLoaded) {
        UINib *headerNib = [UINib nibWithNibName:@"KGCalendarHeaderView" bundle:nil];
        [self registerNib:headerNib forDecorationViewOfKind:__calendarHeaderKind];
        _headerNibLoaded = YES;
    }
}

- (CGSize) collectionViewContentSize {
    CGSize size = CGSizeMake(self.cellSide * self.columns, self.cellSide * self.rows);
    return size;
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributesInRect = [[[NSMutableArray alloc] init] autorelease];
    
    for (UICollectionViewLayoutAttributes *attributes in [self.layoutInfo allValues]) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [attributesInRect addObject:attributes];
        }
    }
    
    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [self.layoutInfo objectForKey:indexPath];
    return attributes;
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [self.layoutInfo objectForKey:decorationViewKind];
    return attributes;
}

- (void) prepareLayout {
    
    KGCalendarViewController *delegate = nil;
    if (self.collectionView.delegate) {
        if ([self.collectionView.delegate isKindOfClass:[KGCalendarViewController class]]) {
            delegate = (KGCalendarViewController *)self.collectionView.delegate;
        }
    }
    
     NSAssert(delegate != nil, @"No delegate for layout");
    int minCellsCount = delegate.calendarSheet.count + delegate.firstDayOffset + 1;
    while (minCellsCount % self.columns != 0) {
        minCellsCount++;
    }
    
    self.rows = minCellsCount / self.columns;
    
    for (int section = 0; section < [self.collectionView numberOfSections]; ++section) {
        for (int cell = 0; cell < [self.collectionView numberOfItemsInSection:section]; ++cell) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:cell inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = [self frameForCellAtIndexPath:indexPath];
            [self.layoutInfo setObject:attributes forKey:indexPath];
        }
    }
    
    UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:__calendarHeaderKind withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    headerAttributes.frame = [self frameForHeader];
    [self.layoutInfo setObject:headerAttributes forKey:__calendarHeaderKind];
}

- (CGRect) frameForCellAtIndexPath:(NSIndexPath *)indexPath {
    int cellRow = (int)indexPath.row / self.columns;
    int cellColumn = (int)indexPath.row % self.columns;
    
    float originX = self.cellSide * cellColumn;
    float originY =  self.cellSide * cellRow;
    
    return CGRectMake(originX, originY, self.cellSide, self.cellSide);
}

- (CGRect) frameForHeader {
    CGRect collectionViewBounds = [self.collectionView bounds];
    CGRect headerDefaultBounds = [KGCalendarHeaderView defaultBounds];
    CGRect headerBounds = CGRectMake(collectionViewBounds.origin.x, collectionViewBounds.origin.y - headerDefaultBounds.size.height + 1, headerDefaultBounds.size.width, headerDefaultBounds.size.height);
    return headerBounds;
}

@end
