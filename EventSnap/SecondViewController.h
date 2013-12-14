//
//  SecondViewController.h
//  EventSnap
//
//  Created by Eric Lee on 11/10/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface SecondViewController : UIViewController <UIImagePickerControllerDelegate,
UINavigationControllerDelegate> {
    MBProgressHUD *HUD;
}

@property BOOL newMedia;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) PFObject *eventObject;
@property (nonatomic) id delegate;



- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;
- (IBAction)addBanner:(id)sender;
- (IBAction)saveImage:(id)sender;

@end
