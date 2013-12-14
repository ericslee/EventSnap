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
#import "BannerCollectionViewCell.h"

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
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // Load banner images
    /*
    _bannerImages.bannerImages = [NSArray arrayWithObjects: @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", nil];
     */
    _banners = [NSArray arrayWithObjects: @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", nil];
    //[_bannerImages reloadData];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _bannerImages = [[BannerCollectionView alloc] initWithFrame:CGRectMake(0,0,320,200) collectionViewLayout:layout];
    _bannerImages.delegate = self;
    _bannerImages.dataSource = self;
    [_bannerImages reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"Calling number of sections");
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"Calling number of items in section");
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"CellForItemAtIndexPath");
    // Set up cell identifier that matches the Storyboard cell name
    static NSString *identifier = @"BannerCell";
    BannerCollectionViewCell *cell = (BannerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:[_banners objectAtIndex:indexPath.row]];
    
    return cell;
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
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            //2
            //Add the image to the object, and add the comment and the user
            PFObject *imageObject = [PFObject objectWithClassName:@"ImageObject"];
            [imageObject setObject:file forKey:@"image"];
            //[imageObject setObject:[PFUser currentUser].username forKey:@"user"];
            //[imageObject setObject:self.commentTextField.text forKey:@"comment"];
            //3
            [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                //4
                if (succeeded){
                    // Display success alert
                    UIAlertView *uploadedImageAlert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                                message:@"Image successfully uploaded to photo stream."
                                                                               delegate:self
                                                                      cancelButtonTitle:@"Cool, thanks!"
                                                                      otherButtonTitles:nil, nil];
                    [uploadedImageAlert show];

                    //Go back to the wall
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [errorAlertView show];
                }
            }];
        }
        else{
            //5
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    } progressBlock:^(int percentDone) {
        NSLog(@"Uploaded: %d %%", percentDone);
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
