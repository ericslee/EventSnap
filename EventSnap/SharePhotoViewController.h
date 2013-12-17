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
#import <Parse/Parse.h>


@interface SharePhotoViewController : UIViewController {
    IBOutlet UIImageView *socialBalloon;
}
@property (strong, nonatomic) IBOutlet UITextField *postText;
@property (strong, nonatomic) PFObject *eventObject;
- (IBAction)postPhoto:(id)sender;

@end
