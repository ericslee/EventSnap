//
//  SecondViewController.m
//  EventSnap
//
//  Created by Eric Lee on 11/10/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "SecondViewController.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
#import "AppDelegate.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Change button color
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.title = @"ShareButton";
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.eventObject = appDelegate.currentEventObject;
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Change to camera
- (void) useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        
        // allow basic user editing
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = YES;
    }
}

// Access saved photos
- (void) useCameraRoll:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = NO;
    }
}

// add banner to photo
- (IBAction)addBanner:(id)sender
{
    // TODO: limit to only adding one banner
    NSLog(@"adding banner");
    
    // Get reference to the picture taken
    UIImage *img1 = _imageView.image;
    // Get reference to banner image to add
    // TODO: generalize to banners pulled from...Parse?
    UIImage *banner = [UIImage imageNamed:@"Test_Banner"];
    
    // TODO: fix scaling hack
    // Scale banner to screen width
    UIImage *scaledImage =
    [UIImage imageWithCGImage:[banner CGImage]
                        scale:(banner.scale * 1/3.0)
                  orientation:(banner.imageOrientation)];
    
    UIGraphicsBeginImageContext(img1.size);
    [img1 drawAtPoint:CGPointMake(0, 0)];
    [scaledImage drawAtPoint:CGPointMake(325, 2500)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imageView.image = resultingImage;
    //return resultingImage;
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        _imageView.image = image;
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)saveImage:(id)sender {
    
    NSData *pictureData = UIImageJPEGRepresentation(_imageView.image, 0.5);
    
    PFFile *file = [PFFile fileWithName:@"img" data:pictureData];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
    [HUD show:YES];
    
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            //2
            
            //setting up loading button
            [HUD hide:YES];
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.delegate = self;
            
            PFObject *imageObject = [PFObject objectWithClassName:@"ImageObject"];
            imageObject[@"image"] = file;
            
            [self.eventObject addObject:imageObject forKey:@"event_pictures"];
            
            //3
            [self.eventObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                //4
                if (!error) {
                    //[self.delegate queryForTable];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            //5
            [HUD hide:YES];
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    } progressBlock:^(int percentDone) {
        HUD.progress = (float)percentDone/100;
    }];
}

    
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
