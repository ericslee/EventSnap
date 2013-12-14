//
//  EditEventInformationViewController.h
//  EventSnap
//
//  Created by Tara Siegel on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface EditEventInformationViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate> {
    IBOutlet UITextField *eventNameField;
    IBOutlet UITextField *startDateField;
    IBOutlet UITextField *endDateField;
    IBOutlet UITextField *locationField;
    IBOutlet UITextField *hashTagsField;
}

@property (nonatomic, strong) PFObject *eventObject;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

- (IBAction)updateEvent:(id)sender;
- (IBAction)goBack:(id)sender;

@end