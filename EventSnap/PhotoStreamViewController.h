//
//  PhotoStreamViewController.h
//  EventSnap
//
//  Created by Eric Lee on 11/26/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface PhotoStreamViewController : UICollectionViewController {
    MBProgressHUD *refreshHUD;
    NSMutableArray *eventPictures;
    IBOutlet UIButton *addPhotoLabel;
}

//@property (strong, nonatomic) IBOutlet UILabel *addPhotoLabel;
@property (strong, nonatomic) NSMutableArray *photoStreamImages;
@property (strong, nonatomic) NSMutableArray *photoStreamIDs;

@property (nonatomic, strong) PFObject *eventObject;
- (IBAction)transitionToCamera:(id)sender;

@end
