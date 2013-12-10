//
//  PhotoStreamViewController.m
//  EventSnap
//
//  Created by Eric Lee on 11/26/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "PhotoStreamViewController.h"
#import "PhotoStreamViewCell.h"
#import "PhotoStreamImageViewController.h"

@interface PhotoStreamViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation PhotoStreamViewController

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
    
    
    // INSERT IMAGES FROM PARSE INTO THIS ARRAY (can use NSMutableArray instead if that's easier)
    _photoStreamImages = [NSArray arrayWithObjects: @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", @"thumbnail", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Set up cell identifier that matches the Storyboard cell name
    static NSString *identifier = @"Cell";
    PhotoStreamViewCell *cell = (PhotoStreamViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:[_photoStreamImages objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PhotoDetailSegue"]) {
        PhotoStreamViewCell *cell = (PhotoStreamViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        PhotoStreamImageViewController *vc = (PhotoStreamImageViewController *)[segue destinationViewController];
        vc.image = [UIImage imageNamed:[_photoStreamImages objectAtIndex:indexPath.row]];
    }
}

- (IBAction)transitionToCamera:(id)sender
{
    [self performSegueWithIdentifier:@"CameraView" sender:self];
}

@end
