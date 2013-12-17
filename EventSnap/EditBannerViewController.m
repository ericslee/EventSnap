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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wet_snow.png"]];

	// Do any additional setup after loading the view.
    
    // Set the background image of the banner as transparent (very tiny image file size)
    _bannerComposite = [UIImage imageNamed:@"largeTransparent"];
    _bannerText.delegate = self;
    
    // Initialize banner to white
    _bannerColor = [UIColor whiteColor];
    
    _colorPreview.layer.borderColor = [UIColor blackColor].CGColor;
    _colorPreview.layer.borderWidth = 1.0;
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [_colorPreview addGestureRecognizer:singleFingerTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearBanner:(id)sender
{
    
}

- (void)closeKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //NSLog(@"Started editing target!");
    _customBannerText = _bannerText.text;
    //NSLog(_customBannerText);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    //NSLog(@"Started editing target!");
    _customBannerText = _bannerText.text;
    //NSLog(_customBannerText);
}

- (void)setSentence:(id)sender
{
    _customBannerText = _bannerText.text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)pickColor:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ColorPickerViewController *colorPickerViewController = [storyboard instantiateViewControllerWithIdentifier:@"colorPicker"];
    colorPickerViewController.bannerViewController = self;
    [self.navigationController pushViewController:colorPickerViewController animated:YES];
    //[self performSegueWithIdentifier:@"colorPicker" sender:self];
}

// Sets the color for the banner
- (void)setColor:(UIColor *)c
{
    _bannerColor = c;
    [_colorPreview setBackgroundColor:_bannerColor];
}

// The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    [self pickColor:self];
}

- (void)addBanner:(id)sender
{
    // Set the background image of the banner as transparent (very tiny image file size)
    _bannerComposite = [UIImage imageNamed:@"largeTransparent"];
    _imageView.image = _bannerComposite;
    UIImage *img1 = _imageView.image;

    UIGraphicsBeginImageContext(img1.size);
    [img1 drawAtPoint:CGPointMake(0, 0)];

    // Drawing Rect
    CGRect rectangle = CGRectMake(0, 500, 1020, 100);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Get RGBA from the banner color
    CGFloat red, green, blue, alpha;
    [_bannerColor getRed: &red
                   green: &green
                    blue: &blue
                   alpha: &alpha];
    
    //CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.5);   //this is the transparent color
    CGContextSetRGBFillColor(context, red, green, blue, 0.5);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.5);
    CGContextFillRect(context, rectangle);
    //CGContextStrokeRect(context, rectangle);    //this will draw the border
 
    // Draw text
    UIFont *textFont = [UIFont fontWithName:@"Noteworthy-Bold" size:50];
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    CGFloat fontHeight = textFont.pointSize;
    //CGFloat yOffset = (rectangle.size.height - fontHeight) / 2.0;
    CGFloat yOffset = (rectangle.size.height - (fontHeight * 2.0)) / 2.0;
    CGRect textRect = CGRectMake(rectangle.origin.x, rectangle.origin.y + yOffset, rectangle.size.width, fontHeight*2);
    
    [_customBannerText drawInRect: textRect withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:paragraphStyle}];
    
    // composite the rectangle onto the existing banner
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imageView.image = resultingImage;
}

- (void)saveBanner:(id)sender
{
    /*
    // Set the background image of the banner as transparent (very tiny image file size)
    UIImage *img1 = _bannerComposite;
    
    // Get reference to banner image to add
    UIImage *banner = [UIImage imageNamed:@"eventSnapLogo"];
    
    // Scale banner to screen width
    UIImage *scaledImage =
    [UIImage imageWithCGImage:[banner CGImage]
                        scale:(banner.scale * 1/9.0)
                  orientation:(banner.imageOrientation)];
    
    UIGraphicsBeginImageContext(img1.size);
    [img1 drawAtPoint:CGPointMake(0, 0)];
    [scaledImage drawAtPoint:CGPointMake(0, 0)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imageView.image = resultingImage;
    */
    // TESTING SENDING BANNERS TO PARSE USING MY KITTY
    //_imageView.image = [UIImage imageNamed:@"thumbnail"];
    
    NSData *pictureData = UIImagePNGRepresentation(_imageView.image);
    //NSData *pictureData = UIImageJPEGRepresentation(_imageView.image, 0.5);
    
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
                    
                    // Uncomment to automatically return to previous screen after saving
                    //[self.navigationController popViewControllerAnimated:YES];
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
