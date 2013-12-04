//
//  PhotoStreamViewController.m
//  EventSnap
//
//  Created by Eric Lee on 11/26/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "PhotoStreamViewController.h"

@interface PhotoStreamViewController ()

@end

@implementation PhotoStreamViewController

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

- (IBAction)transitionToCamera:(id)sender
{
    [self performSegueWithIdentifier:@"CameraView" sender:self];
}

@end
