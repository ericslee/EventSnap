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

@interface EditBannerViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate> {
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) PFObject *eventObject;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *bannerTextView;
@property (strong, nonatomic) IBOutlet UITextField *bannerText;
@property (strong, nonatomic) UIImage *bannerComposite;
@property (strong, nonatomic) NSString *customBannerText;
@property (strong, nonatomic) UIColor *bannerColor;

- (IBAction)saveBanner:(id)sender;
- (IBAction)clearBanner:(id)sender;
- (IBAction)addBanner:(id)sender;
- (IBAction)changeToRedBanner:(id)sender;
- (IBAction)changeToBlueBanner:(id)sender;

- (IBAction)setSentence:(id)sender;
- (IBAction)closeKeyboard:(id)sender;

- (IBAction)pickColor:(id)sender;
@end
