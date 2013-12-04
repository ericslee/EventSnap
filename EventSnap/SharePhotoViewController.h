//
//  SharePhotoViewController.h
//  EventSnap
//
//  Created by Eric Lee on 12/4/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface SharePhotoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *postText;
- (IBAction)postPhoto:(id)sender;

@end
