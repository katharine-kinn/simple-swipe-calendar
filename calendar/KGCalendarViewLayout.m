//
//  KGCalendarViewLayout.m
//  calendar
//
//  Created by Catherine on 31/03/2014.
//
//

#import "KGCalendarViewLayout.h"
#import "KGCalendarCore.h"

@implementation KGCalendarViewLayout

- (id) init {
    if ((self = [super init])) {
        self.layoutInfo = [[[NSMutableDictionary alloc] init] autorelease];
        [self setup];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.layoutInfo = [[[NSMutableDictionary alloc] init] autorelease];
        [self setup];
    }
    return self;
}

- (void) dealloc {
    self.layoutInfo = nil;
    [super dealloc];
}

- (void) setup {
    self.columns = 7;
    
    int minCellsCount = [KGCalendarCore sharedCalendarCore].currentMonthDaysCount + [KGCalendarCore sharedCalendarCore].currentFirstMonthDayOffset + 1;
    
    while (minCellsCount % self.columns != 0) {
        minCellsCount++;
    }
    
    self.rows = minCellsCount / self.columns;
    self.cellSide = 42;
    
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

- (void) prepareLayout {
    for (int section = 0; section < [self.collectionView numberOfSections]; ++section) {
        for (int cell = 0; cell < [self.collectionView numberOfItemsInSection:section]; ++cell) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:cell inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = [self frameForCellAtIndexPath:indexPath];
            [self.layoutInfo setObject:attributes forKey:indexPath];
        }
    }
}

- (CGRect) frameForCellAtIndexPath:(NSIndexPath *)indexPath {
    int cellRow = (int)indexPath.row / self.columns;
    int cellColumn = (int)indexPath.row % self.columns;
    
    float originX = self.cellSide * cellColumn;
    float originY =  self.cellSide * cellRow;
    
    return CGRectMake(originX, originY, self.cellSide, self.cellSide);
}

@end
