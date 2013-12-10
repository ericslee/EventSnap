//
//  PhotoStreamImageViewController.m
//  EventSnap
//
//  Created by Eric Lee on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "PhotoStreamImageViewController.h"

@interface PhotoStreamImageViewController ()

@end

@implementation PhotoStreamImageViewController

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
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
