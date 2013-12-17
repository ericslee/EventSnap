//
//  PhotoStreamImageViewController.m
//  EventSnap
//
//  Created by Eric Lee on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "PhotoStreamImageViewController.h"
#import <Parse/Parse.h>

@interface PhotoStreamImageViewController ()

@end

@implementation PhotoStreamImageViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wet_snow.png"]];
	// Do any additional setup after loading the view.
    self.imageView.image = self.image;
    
    PFObject *otherUser = self.eventObject[@"event_organizer"];
    PFObject *currentUser = [PFUser currentUser];
    if ([otherUser.objectId isEqualToString:currentUser.objectId]) {
        deletePhoto.hidden = FALSE;
    }
    else {
        deletePhoto.hidden = TRUE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)deletePhoto:(id)sender{
    PFQuery *query = [PFQuery queryWithClassName:@"ImageObject"];
    
    [query getObjectInBackgroundWithId:self.imageID block:^(PFObject *imageToDelete, NSError *error) {
        [imageToDelete deleteInBackground];
        [self.eventObject removeObject:imageToDelete forKey:@"event_pictures"];
        [self.eventObject saveInBackground];
    }];
    
    
   
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
