//
//  EditSelectedEventViewController.h
//  EventSnap
//
//  Created by Tara Siegel on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditSelectedEventViewController : UIViewController

@property (nonatomic, strong) PFObject *eventObject;

@end
