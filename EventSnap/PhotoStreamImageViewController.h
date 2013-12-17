//
//  PhotoStreamImageViewController.h
//  EventSnap
//
//  Created by Eric Lee on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PhotoStreamImageViewController : UIViewController {
    IBOutlet UIButton *deletePhoto;
}

@property (strong,nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *imageID;
@property (strong, nonatomic) PFObject *eventObject;
-(IBAction)deletePhoto:(id)sender;

@end
