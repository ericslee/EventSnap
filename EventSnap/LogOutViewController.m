//
//  LogOutViewController.m
//  EventSnap
//
//  Created by Tara Siegel on 12/17/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "LogOutViewController.h"
#import <Parse/Parse.h>
#import "InitialViewController.h"

@interface LogOutViewController ()

@end

@implementation LogOutViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logMeOut:(id)sender {
    if([PFUser currentUser]) {
        [PFUser logOut];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
        

@end
