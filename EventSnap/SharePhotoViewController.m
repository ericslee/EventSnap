//
//  SharePhotoViewController.m
//  EventSnap
//
//  Created by Eric Lee on 12/4/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "SharePhotoViewController.h"
#import "AppDelegate.h"

@interface SharePhotoViewController ()

@end

@implementation SharePhotoViewController

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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.eventObject = appDelegate.currentEventObject;
    _postText.text = self.eventObject[@"event_hashtags"];
    socialBalloon.image = [UIImage imageNamed:@"social_balloon"];
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_postText isFirstResponder] && [touch view] != _postText) {
        [_postText resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)postPhoto:(id)sender {
    NSArray *activityItems;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _postImage = appDelegate.userGlobalImage;
    
    activityItems = @[_postText.text];
    
    if (_postImage != nil) {
        activityItems = @[_postText.text, _postImage];
    } else {
        activityItems = @[_postText.text];
    }
     
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    
    [self presentViewController:activityController
                       animated:YES completion:nil];
}
@end
