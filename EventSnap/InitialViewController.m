//
//  InitialViewController.m
//  EventSnap
//
//  Created by Eric Lee on 11/24/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "InitialViewController.h"
#import "EventOrganizersViewController.h"
#import "EventsListViewController.h"

@interface InitialViewController ()

@property (nonatomic, strong) IBOutlet UIButton *editEventButton;

@end

@implementation InitialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (![PFUser currentUser]){
        _editEventButton.hidden = true;
    }
    else {
        _editEventButton.hidden = false;
    }
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"mainPageBackground"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchEvents:(id)sender
{
    [self performSegueWithIdentifier:@"EventsList" sender:self];
}

- (IBAction)editEventLabel:(id)sender
{
    [self performSegueWithIdentifier:@"OrganizerSignedIn" sender:self];
}

- (IBAction)loginView:(id)sender
{
            // No user logged in
            // Create the log in view controller
    
    if([PFUser currentUser]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged in" message:@"logged in" delegate:nil cancelButtonTitle:@"log me out" otherButtonTitles:nil, nil];
        [alert show];
        //[alert release];
        [PFUser logOut];
    }
    
            PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
            [logInViewController setDelegate:self]; // Set ourselves as the delegate
            
            // Create the sign up view controller
            PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
            [signUpViewController setDelegate:self]; // Set ourselves as the delegate
            
            // Assign our sign up controller to be displayed from the login controller
            [logInViewController setSignUpController:signUpViewController];
            
            // Present the log in view controller
            [self presentViewController:logInViewController animated:YES completion:NULL];
    logInViewController.delegate = self;
    logInViewController.signUpController.delegate = self;
    }

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self performSegueWithIdentifier:@"OrganizerSignedIn" sender:self];
    _editEventButton.hidden = false;

}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
    if ([PFUser currentUser]){
        _editEventButton.hidden = false;
    }
    else {
        _editEventButton.hidden = true;
    }
}

/*- (IBAction)viewAllEvents:(id)sender
{
    EventsListViewController *allEvents = [[EventsListViewController alloc] init];
    
}*/



@end
