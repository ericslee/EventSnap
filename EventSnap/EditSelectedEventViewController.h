//
//  EditSelectedEventViewController.h
//  EventSnap
//
//  Created by Tara Siegel on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "EditEventPhotos.h"

@interface EditSelectedEventViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) PFObject *eventObject;
@property (strong, nonatomic) NSMutableArray *photoStreamImages;
@property (strong, nonatomic) NSMutableArray *photoStreamIDs;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)editEventInformation:(id)sender;
- (IBAction)editBanners:(id)sender;

@end
