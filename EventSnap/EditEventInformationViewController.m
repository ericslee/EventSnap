//
//  EditEventInformationViewController.m
//  EventSnap
//
//  Created by Tara Siegel on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "EditEventInformationViewController.h"
#import "EditSelectedEventViewController.h"

@interface EditEventInformationViewController ()

@property (nonatomic, retain) UIToolbar *keyboardToolbar;
-(void)previousField:(id)sender;
-(void)nextField:(id)sender;
-(void)setupKeyboard;
-(void)resignKeyboard:(id)sender;
- (void)startPickerChanged:(id)sender;
- (void)endPickerChanged:(id)sender;

@end

@implementation EditEventInformationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(resignKeyboard:)];
    //[self.view addGestureRecognizer:tap];
    [self setupKeyboard];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wet_snow.png"]];

    UIDatePicker *startDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0,320,200)];
    [startDatePicker addTarget:self
                        action:@selector(startPickerChanged:)
              forControlEvents:UIControlEventValueChanged];
    
    startDatePicker.minimumDate = [NSDate date];
    
    UIDatePicker *endDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0,320,200)];
    [endDatePicker addTarget:self
                      action:@selector(endPickerChanged:)
            forControlEvents:UIControlEventValueChanged];
    
    endDatePicker.minimumDate = [NSDate date];
    eventNameField.inputAccessoryView = self.keyboardToolbar;
    startDateField.inputAccessoryView = self.keyboardToolbar;
    endDateField.inputAccessoryView = self.keyboardToolbar;
    locationField.inputAccessoryView = self.keyboardToolbar;
    hashTagsField.inputAccessoryView = self.keyboardToolbar;
    startDateField.inputView = startDatePicker;
    endDateField.inputView = endDatePicker;
    
    eventNameField.text = self.eventObject[@"event_name"];
    startDateField.text = [NSString stringWithFormat:@"%@", self.eventObject[@"event_start_date"]];
    endDateField.text = [NSString stringWithFormat:@"%@", self.eventObject[@"event_end_date"]];
    locationField.text = self.eventObject[@"event_location"];
    hashTagsField.text = self.eventObject[@"event_hashtags"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startPickerChanged:(id)sender{
    _startDate = [sender date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    NSString *newTime = [timeFormatter stringFromDate:[[sender date]init] ];
    startDateField.text = newTime;
    // NSLog(@"value: %@", [sender date]);
    
}
- (void)endPickerChanged:(id)sender{
    _endDate = [sender date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    NSString *newTime = [timeFormatter stringFromDate:[[sender date]init] ];
    endDateField.text = newTime;
    // NSLog(@"value: %@", [sender date]);
    
}


- (IBAction)goBack:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditSelectedEventViewController *editViewController = [storyboard instantiateViewControllerWithIdentifier:@"editEventDetail"];
    editViewController.eventObject = self.eventObject;
    [self.navigationController pushViewController:editViewController animated:YES];
}

-(void)previousField:(id)sender {
    if ([startDateField isFirstResponder]) {
        [eventNameField becomeFirstResponder];
    }
    else if ([endDateField isFirstResponder]){
        [startDateField becomeFirstResponder];
    }
    else if ([locationField isFirstResponder]){
        [endDateField becomeFirstResponder];
    }
    else if ([hashTagsField isFirstResponder]){
        [locationField becomeFirstResponder];
    }
}


-(void)nextField:(id)sender {
    if ([eventNameField isFirstResponder]) {
        [startDateField becomeFirstResponder];
    }
    else if ([startDateField isFirstResponder]){
        [endDateField becomeFirstResponder];
    }
    else if ([endDateField isFirstResponder]){
        [locationField becomeFirstResponder];
    }
    else if ([locationField isFirstResponder]){
        [hashTagsField becomeFirstResponder];
    }
}


-(void)resignKeyboard:(id)sender{
    [eventNameField resignFirstResponder];
    [startDateField resignFirstResponder];
    [endDateField resignFirstResponder];
    [locationField resignFirstResponder];
    [hashTagsField resignFirstResponder];
    
}

-(void)setupKeyboard{
    NSLog(@"trying to set up keyboard");
    if(self.keyboardToolbar == nil){
        self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        UIBarButtonItem *previousButton  = [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                           action:@selector(previousField:)];
        
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(nextField:)];
        
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(resignKeyboard:)];
        
        [self.keyboardToolbar setItems:[[NSArray alloc] initWithObjects:previousButton, nextButton, extraSpace, doneButton, nil]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:.4];
    
    [textField resignFirstResponder];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    
    if (eventNameField == textField) {
    }
    if(endDateField == textField){
        viewFrame.origin.y -= 80;
    }
    if(locationField == textField){
        viewFrame.origin.y -= 100;
    }
    if(hashTagsField == textField){
        viewFrame.origin.y -= 120;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:.4];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


- (IBAction)updateEvent:(id)sender{
    
    if([eventNameField.text isEqualToString:@""] ||
       [startDateField.text isEqualToString:@""] ||
       [locationField.text isEqualToString:@""]) {
        UIAlertView *missingFields = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You need to fill everything out" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [missingFields show];
    }
    else {
        NSLog(@"getting to create event");

        self.eventObject[@"event_name"] = eventNameField.text;
        if (_startDate != nil) {
            self.eventObject[@"event_start_date"] = _startDate;
        }
        if (_endDate != nil) {
            self.eventObject[@"event_end_date"] = _endDate;
        }
        self.eventObject[@"event_location"] = locationField.text;
        self.eventObject[@"event_hashtags"] = hashTagsField.text;
        NSLog(@"updated object");
        [self.eventObject saveInBackground];
        EditSelectedEventViewController *selected = [[EditSelectedEventViewController alloc] init];
        selected.eventObject = self.eventObject;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)deleteEvent:(id)sender{
    [self.eventObject deleteInBackground];
    EditSelectedEventViewController *selected = [[EditSelectedEventViewController alloc] init];
    [selected.eventObject deleteInBackground];
    [self.navigationController popViewControllerAnimated:YES];
}

@end