//
//  PhotoStreamViewController.h
//  EventSnap
//
//  Created by Eric Lee on 11/26/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PhotoStreamViewController : UICollectionViewController

@property (strong, nonatomic) NSMutableArray *photoStreamImages;
@property (nonatomic, strong) PFObject *eventObject;
- (IBAction)transitionToCamera:(id)sender;

@end
