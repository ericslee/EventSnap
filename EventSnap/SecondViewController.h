//
//  SecondViewController.h
//  EventSnap
//
//  Created by Eric Lee on 11/10/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface SecondViewController : UIViewController <UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property BOOL newMedia;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;
- (IBAction)addBanner:(id)sender;

@end
