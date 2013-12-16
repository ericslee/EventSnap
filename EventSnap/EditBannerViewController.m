//
//  EditBannerViewController.m
//  EventSnap
//
//  Created by Eric Lee on 12/16/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "EditBannerViewController.h"

@interface EditBannerViewController ()

@end

@implementation EditBannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveBanner:(id)sender {
    
    // TESTING SENDING BANNERS TO PARSE USING MY KITTY
    _imageView.image = [UIImage imageNamed:@"thumbnail"];
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
            
            [self.eventObject addObject:imageObject forKey:@"event_banners"];
            
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

@end
