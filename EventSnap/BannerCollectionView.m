//
//  BannerCollectionView.m
//  EventSnap
//
//  Created by Eric Lee on 12/11/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "BannerCollectionView.h"
#import "BannerCollectionViewCell.h"

@implementation BannerCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSLog(@"Initializing banner collection view");
        // INSERT IMAGES FROM PARSE INTO THIS ARRAY (can use NSMutableArray instead if that's easier)
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"Calling number of items in section");
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"CellForItemAtIndexPath");
    // Set up cell identifier that matches the Storyboard cell name
    static NSString *identifier = @"BannerCell";
    BannerCollectionViewCell *cell = (BannerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    //cell.imageView.image = [UIImage imageNamed:[_bannerImages objectAtIndex:indexPath.row]];
    
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
