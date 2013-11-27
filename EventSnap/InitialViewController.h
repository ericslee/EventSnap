//
//  InitialViewController.h
//  EventSnap
//
//  Created by Eric Lee on 11/24/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface InitialViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

- (IBAction)searchEvents:(id)sender;
- (IBAction)loginView:(id)sender;

@end
