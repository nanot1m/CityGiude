//
//  CatalogiPhoneFlowLayout.m
//  AppsPublisher
//
//  Created by Dmitry Kuznetsov on 17/06/14.
//  Copyright (c) 2014 Appsgroup. All rights reserved.
//

#import "CategoryTileFlowLayout.h"
//#import "BookShelfiPadLandscapeDecorationView.h"
//#import "CatalogHeaderView.h"

static NSString * const catalogCellKind = @"CatalogCell"; //key for CatalogCells

@implementation CategoryTileFlowLayout{
    NSDictionary *_layoutInfo; //store all layout information
//    NSDictionary *_headerRect; //store info about header
    NSDictionary *_shelvesRect; //store shelf layout info
}

-(id)init{
    self = [super init];
    
    if(self){
        [self setDefaultValues]; // Specify Flow Layout properties
        
    }
    
    return self;
}

-(void)setDefaultValues{
    
    CGFloat sizeOfItems = [UIScreen mainScreen].bounds.size.width / 2;
    self.itemSize = CGSizeMake(sizeOfItems, sizeOfItems); //size of each cell
    self.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, sizeOfItems, 0.0f);
    self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    self.numberOfColumns = 2;
    self.interItemSpacingY = 0.0f;
    
    self.headerViewHeight = 0.0f;
    
    //Register Decoration View Class
//    [self registerClass:[BookShelfiPadLandscapeDecorationView class] forDecorationViewOfKind:[BookShelfiPadLandscapeDecorationView kind]];

}


#pragma mark - Layout

-(void)prepareLayout{
    
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary]; //temp dict for attributes
//    NSMutableDictionary *headerLayoutInfo = [NSMutableDictionary dictionary]; //temp dict for header view attributes
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0]; //number of items in section. I have only 1 section
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0]; //default value for indexpath
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary]; //store temp info for shelves
//    CGFloat y = 0;
    
    for(NSInteger item = 0; item < itemCount; item++){
        indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        
        UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        itemAttributes.frame = [self frameForCellAtIndexPath:indexPath];
        
        cellLayoutInfo[indexPath] = itemAttributes;
        //NSLog(@"itemAttributes = %@", itemAttributes);
        
//        if (indexPath.item == 0) {
//            UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes
//                                                                  layoutAttributesForSupplementaryViewOfKind:[CatalogHeaderView kind]
//                                                                  withIndexPath:indexPath];
//            headerAttributes.frame = [self frameForAlbumTitleAtIndexPath:indexPath];
//            
//            headerLayoutInfo[indexPath] = headerAttributes;
//        }
//        
//        if(item % 2 == 0){
//            //NSLog(@"item: %i; indexpath.row: %@", item, indexPath);
//            //y += self.headerReferenceSize.height;
//            
//            y += self.itemSize.height;
//            
//            dict[indexPath] = [NSValue valueWithCGRect:CGRectMake(0, y + 40, self.collectionViewContentSize.width, 84)];
//            
//            y += self.interItemSpacingY;
//            //y += self.sectionInset.top;
//            //y += self.sectionInset.bottom;
//            //y += self.footerReferenceSize.height;
//        }
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary]; //store temp info for shelves
    CGFloat y = 0;

    int rows = ceil(itemCount/(float)self.numberOfColumns);
    
    for(int row = 0; row < rows; row++){
        y += self.itemSize.height;
        
        dict[[NSIndexPath indexPathForItem:row inSection:0]] = [NSValue valueWithCGRect:CGRectMake(0, y + 40, self.collectionViewContentSize.width, 84)];
        y += self.interItemSpacingY;
    }
    
    _layoutInfo = [NSDictionary dictionaryWithDictionary:cellLayoutInfo];
    _shelvesRect = [NSDictionary dictionaryWithDictionary:dict];
}

#pragma mark - Private

//-(CGRect)frameForAlbumTitleAtIndexPath:(NSIndexPath*)indexPath{
//    return CGRectMake(0, 0, self.collectionView.frame.size.width, self.headerViewHeight);
//}

-(CGRect)frameForCellAtIndexPath:(NSIndexPath*)indexPath{
    
//    if(indexPath.item == 0) //hide first item because it is showed in headerView
//        return CGRectZero;
    
    NSInteger row = (indexPath.row) / self.numberOfColumns;
    NSInteger column = (indexPath.row) % self.numberOfColumns;
    
    CGFloat spacingX = self.collectionView.bounds.size.width -
                        self.itemInsets.left -
                        self.itemInsets.right -
                        (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
    CGFloat originY = floor(self.headerViewHeight + self.itemInsets.top + self.sectionInset.top +
                        (self.itemSize.height + self.interItemSpacingY) * row);
    
    //NSLog(@"row = %i, column = %i, spacX = %f, {%f,%f}", row, column, spacingX, originX, originY);
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

#pragma mark - Attributes

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:_layoutInfo.count]; //return store of all attributes
    
    [_layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *innerStop){
        if(CGRectIntersectsRect(rect, attributes.frame)){
            attributes.zIndex = 1;
            [allAttributes addObject:attributes];
        }
    }];
    
    //add decoration view (shelves)
//    [_shelvesRect enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        if (CGRectIntersectsRect([obj CGRectValue], rect))
//        {
//            UICollectionViewLayoutAttributes *attributes;
//            attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[BookShelfiPadLandscapeDecorationView kind] withIndexPath:key];
//            
//            attributes.frame = [obj CGRectValue];
//            attributes.zIndex = 0;
//            [allAttributes addObject:attributes];
//        }
//    }];
    
    return allAttributes;
}

-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    return _layoutInfo[indexPath];
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind
//                                                                     atIndexPath:(NSIndexPath *)indexPath
//{
//    return _headerRect[indexPath];
//}

-(CGSize)collectionViewContentSize{
    
    NSInteger rowCount = ([self.collectionView numberOfItemsInSection:0] - 1) / self.numberOfColumns;
    
    // make sure we count another row if one is only partially filled
    if (([self.collectionView numberOfItemsInSection:0] - 1) % self.numberOfColumns) rowCount++;
    
    CGFloat height = self.headerViewHeight + self.itemInsets.top +
                     rowCount * self.itemSize.height +
                     rowCount * self.interItemSpacingY +
                     self.sectionInset.bottom;
    
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

@end
