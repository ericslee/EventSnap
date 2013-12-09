//
//  EditSelectedEventViewController.m
//  EventSnap
//
//  Created by Tara Siegel on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "EditSelectedEventViewController.h"
#import <Parse/Parse.h>
#import "EventOrganizersViewController.h"

@interface EditSelectedEventViewController ()

@property (nonatomic, strong) IBOutlet UILabel *eventTitle;
@property (nonatomic, strong) IBOutlet UILabel *eventDate;
@property (nonatomic, strong) IBOutlet UILabel *eventLocation;

@end

@implementation EditSelectedEventViewController

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
   self.eventTitle.text = self.eventObject[@"event_name"];
    self.eventLocation.text = self.eventObject[@"event_location"];
    self.eventDate.text = [NSString stringWithFormat:@"%@",
                           self.eventObject[@"event_start_date"]];
    //self.eventLocation.text = self.eventObject[@"event_start_date"];
   // self.eventDate.text = self.eventObject[@"event_location"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
