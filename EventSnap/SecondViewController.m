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
#import "AppDelegate.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wet_snow.png"]];
	// Do any additional setup after loading the view, typically from a nib.
    
    // load imagepicker
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.title = @"ShareButton";
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.eventObject = appDelegate.currentEventObject;
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //_bannerImages = [[UICollectionView alloc] initWithFrame:self.view.bounds];
    /*
     UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
     [layout setItemSize:CGSizeMake(100, 100)];
     [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
     [_bannerImages setCollectionViewLayout:layout];
     */
    _bannerImages.delegate = self;
    
    // Load banner images
    // each event banner element
    NSArray *eventPointers = self.eventObject[@"event_banners"];
    eventBanners = [NSMutableArray array];
    
    // query for an object of class ImageObject
    PFQuery *query = [PFQuery queryWithClassName:@"ImageObject"];
    if (eventPointers.count != 0) {
        for (int i = 0; i < eventPointers.count; i++){
            PFObject *eventPic = [eventPointers objectAtIndex:i];
            PFObject *picObj = [query getObjectWithId:eventPic.objectId];
            PFFile *file = picObj[@"image"];
            NSData *data = [file getData];
            UIImage *eventImage = [UIImage imageWithData:data];
            [eventBanners addObject:eventImage];
            
        }
        _banners = eventBanners;
    }
    
    /*
     _bannerImages = [[BannerCollectionView alloc] initWithFrame:CGRectMake(320,200) collectionViewLayout:layout];*/
    //_bannerImages.dataSource = self;
    //NSLog(@"%d", [_bannerImages numberOfSections]);
    //[_bannerImages reloadData];
    
    // Change button color
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    _hasBanner = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // only one row
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // the single row contains all the banners in the banners array
    return [_banners count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Set up cell identifier that matches the Storyboard cell name
    static NSString *identifier = @"BannerCell";
    BannerCollectionViewCell *cell = (BannerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor redColor];
    if ([_banners count] != 0) {
        //cell.imageView.image = [UIImage imageNamed:[_banners objectAtIndex:indexPath.row]];
        cell.imageView.image = _banners[indexPath.row];
    }
    
    
    return cell;
}

// perform action when a cell is selected
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _bannerToAdd = _banners[indexPath.row];
    [self addBanner:self];
}

// Change to camera
- (void) useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        //UIImagePickerController *imagePicker =
        //[[UIImagePickerController alloc] init];
        //_imagePicker.delegate = self;
        _imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        _imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        
        // allow basic user editing
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker
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
        //UIImagePickerController *imagePicker =
        //[[UIImagePickerController alloc] init];
        //imagePicker.delegate = self;
        _imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        _imagePicker.allowsEditing = NO;
        [self presentViewController:_imagePicker
                           animated:YES completion:nil];
        _newMedia = NO;
    }
}

// add banner to photo
- (IBAction)addBanner:(id)sender
{
    
    if(!_hasBanner) {
        _baseImage = _imageView.image;
        _hasBanner = YES;
    }
    
    // Get reference to the picture taken
    UIImage *img1 = _baseImage;
    
    NSLog(@"%f", img1.size.width);

    // width x height
    // 960 x 1280 front
    // 1280 x 960 landscape front
    // 2448 x 3264 back
    // 3264 x 2448 landscape back
    // * 3.2
        
    // Get reference to banner image to add
    //if(_bannerToAdd != NULL) {
    UIImage *banner = _bannerToAdd;
    //}
    
    _imageView.image = banner;
        
    // Image taken from front facing camera
    if(img1.size.width < 1000.0f) {
        // Scale banner to screen width
        UIImage *scaledImage =
        [UIImage imageWithCGImage:[banner CGImage]
                            scale:(banner.scale)
                      orientation:(banner.imageOrientation)];
            
        UIGraphicsBeginImageContext(img1.size);
        [img1 drawAtPoint:CGPointMake(0, 0)];
            
        // y coordinate found through trial and error...
        //[scaledImage drawAtPoint:CGPointMake(0, 400)];
        [scaledImage drawAtPoint:CGPointMake(0, img1.size.height / 3.0)];
        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _imageView.image = resultingImage;
    }
    /*
    else if(img1.size.width < 1500.0f) {
        // Scale banner to screen width
        UIImage *scaledImage =
        [UIImage imageWithCGImage:[banner CGImage]
                            scale:(banner.scale * 1.0)
                      orientation:(banner.imageOrientation)];
        
        UIGraphicsBeginImageContext(img1.size);
        [img1 drawAtPoint:CGPointMake(0, 0)];
        
        // y coordinate found through trial and error...
        //[scaledImage drawAtPoint:CGPointMake(0, 400)];
        [scaledImage drawAtPoint:CGPointMake(0, img1.size.height / 2.5)];
        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _imageView.image = resultingImage;
    }
     */
    // Image taken from back facing camera
    else {
        // Scale banner to screen width
        UIImage *scaledImage =
        [UIImage imageWithCGImage:[banner CGImage]
                            scale:(banner.scale * 1.0/2.5)
                      orientation:(banner.imageOrientation)];
            
        UIGraphicsBeginImageContext(img1.size);
        [img1 drawAtPoint:CGPointMake(0, 0)];
            
        // y coordinate found through trial and error...
        //[scaledImage drawAtPoint:CGPointMake(0, 1200)];
        [scaledImage drawAtPoint:CGPointMake(0, img1.size.height / 3.0)];
        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _imageView.image = resultingImage;
    }
    
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SharePhotoViewController *sharePhotoController = [storyboard instantiateViewControllerWithIdentifier:@"SocialMediaView"];
    sharePhotoController.postImage = _imageView.image;
     */
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.userGlobalImage = _imageView.image;
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
    
    if (_imageView.image == NULL){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"No Image Selected"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    else {
    
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
