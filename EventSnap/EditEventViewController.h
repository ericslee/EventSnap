//
//  EditEventViewController.h
//  EventSnap
//
//  Created by Tara Siegel on 12/5/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditEventViewController : UIViewController

@property (nonatomic, strong) PFObject *eventObject;

@end
