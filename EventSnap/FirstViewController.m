//
//  FirstViewController.m
//  EventSnap
//
//  Created by Eric Lee on 11/10/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //[testObject setObject:@"OMG" forKey:@"foo"];
    //[testObject save];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickTheButton:(id)sender
{
    NSLog(@"Test");
}

@end
