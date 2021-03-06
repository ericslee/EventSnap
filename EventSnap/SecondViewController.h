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
#import "SharePhotoViewController.h"

@interface SecondViewController : UIViewController <UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,
UINavigationControllerDelegate> {
    MBProgressHUD *HUD;
    NSMutableArray *eventBanners;
}


@property BOOL newMedia;
@property BOOL hasBanner;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UICollectionView *bannerImages;
@property (strong, nonatomic) NSMutableArray *banners;
@property (strong, nonatomic) PFObject *eventObject;
@property (nonatomic) id delegate;
@property (strong, nonatomic) UIImage *bannerToAdd;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIImage *baseImage;

- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;
- (IBAction)addBanner:(id)sender;
- (IBAction)saveImage:(id)sender;
- (IBAction)setBanner:(id)sender;
@end
