//
//  InitialViewController.h
//  EventSnap
//
//  Created by Eric Lee on 11/24/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "EventOrganizersViewController.h"
#import "EventsListViewController.h"


@interface InitialViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate> {
    IBOutlet UILabel *eventOrganizerLabel;
    IBOutlet UIButton *editEventButton;
    IBOutlet UIButton *logIn;
    IBOutlet UIButton *logOut;
    
}

- (IBAction)searchEvents:(id)sender;
- (IBAction)loginView:(id)sender;
- (IBAction)logOutView:(id)sender;
- (IBAction)editEventLabel:(id)sender;
//- (IBAction)viewAllEvents:(id)sender;

@end
