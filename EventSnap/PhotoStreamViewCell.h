//
//  PhotoStreamViewCell.h
//  EventSnap
//
//  Created by Eric Lee on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//
//  Holds the image in each cell

#import <UIKit/UIKit.h>

@interface PhotoStreamViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString *photoObjectID;

@end
