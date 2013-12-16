//
//  EditBannerViewController.h
//  EventSnap
//
//  Created by Eric Lee on 12/16/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface EditBannerViewController : UIViewController {
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) PFObject *eventObject;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)saveBanner:(id)sender;
- (IBAction)clearBanner:(id)sender;
@end
