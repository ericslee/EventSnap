//
//  TFSUserRegistrationViewController.m
//  EventSnap
//
//  Created by Tara Siegel on 11/24/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "TFSUserRegistrationViewController.h"

@interface TFSUserRegistrationViewController ()

@property (nonatomic, retain) UIToolbar *keyboardToolbar;
//-(void)previousField:(id)sender;
//-(void)nextField:(id)sender;
//-(void)setupKeyboard;
//-(void)resignKeyboard:(id)sender;

@end

@implementation TFSUserRegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

   // [self setupKeyboard];
   // nameField.inputAccessoryView = self.keyboardToolbar;
   // emailField.inputAccessoryView = self.keyboardToolbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
- (IBAction)dismissModal:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Nevermind"
                                               destructiveButtonTitle:@"Cancel"
                                                    otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)previousField:(id)sender {
    if ([emailField isFirstResponder]) {
        [nameField becomeFirstResponder];
    }
    else if ([passwordField isFirstResponder]){
        [emailField becomeFirstResponder];
    }
}


-(void)nextField:(id)sender {
    if ([nameField isFirstResponder]) {
        [emailField becomeFirstResponder];
    }
    else if ([emailField isFirstResponder]){
        [passwordField becomeFirstResponder];
    }
}


-(void)resignKeyboard:(id)sender{
    [nameField resignFirstResponder];
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
}

-(void)setupKeyboard{
    if(self.keyboardToolbar == nil){
        self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous"
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
        
        [self.keyboardToolbar setItems:[[NSArray alloc] initWithObjects: previousButton, nextButton, extraSpace, doneButton, nil]];
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
    
    if (nameField == textField) {
        //_previousButton.isEnabled = false;
    }
    
    if(passwordField == textField){
        viewFrame.origin.y -= 80;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:.4];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}


- (IBAction)registerUser:(id)sender{
    if([nameField.text isEqualToString:@""] ||
       [emailField.text isEqualToString:@""] ||
       [passwordField.text isEqualToString:@""]) {
        UIAlertView *missingFields = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You need to fill everything out" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [missingFields show];
    }
    else {
        PFObject *userObject = [PFObject objectWithClassName:@"Users"];
        [userObject setObject:nameField.text forKey:@"Name"];
        [userObject setObject:emailField.text forKey:@"Email"];
        [userObject setObject:passwordField.text forKey:@"Password"];
        
        [userObject save];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }

    
}*/

@end
