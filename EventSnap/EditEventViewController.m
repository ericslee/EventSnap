//
//  EditEventViewController.m
//  EventSnap
//
//  Created by Tara Siegel on 12/5/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "EditEventViewController.h"

@interface EditEventViewController ()

@property (nonatomic, strong) IBOutlet UILabel *eventTitle;
@property (nonatomic, strong) IBOutlet UILabel *eventDate;
@property (nonatomic, strong) IBOutlet UILabel *eventLocation;

@end

@implementation EditEventViewController

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
    NSString *title = _eventObject[@"event_name"];
    self.eventTitle.text = title;
    self.eventLocation.text = _eventObject[@"event_start_date"];
    self.eventDate.text = _eventObject[@"event_location"];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
