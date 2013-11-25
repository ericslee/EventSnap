//
//  TFSUserRegistrationViewController.h
//  EventSnap
//
//  Created by Tara Siegel on 11/24/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFSUserRegistrationViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate> {
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *emailField;
    IBOutlet UITextField *passwordField;
}

- (IBAction)registerUser:(id)sender;
- (IBAction)dismissModal:(id)sender;

@end
