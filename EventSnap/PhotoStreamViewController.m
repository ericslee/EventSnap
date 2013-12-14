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
#import "AppDelegate.h"

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
    NSArray *eventPointers = self.eventObject[@"event_pictures"];
    NSMutableArray *eventPictures = [NSMutableArray array];
    PFQuery *query = [PFQuery queryWithClassName:@"ImageObject"];
    if (eventPointers.count != 0) {
        for (int i = 0; i < eventPointers.count; i++){
            PFObject *eventPic = [eventPointers objectAtIndex:i];
            PFObject *picObj = [query getObjectWithId:eventPic.objectId];
            PFFile *file = picObj[@"image"];
            NSData *data = [file getData];
            UIImage *eventImage = [UIImage imageWithData:data];
            [eventPictures addObject:eventImage];
        
    }
        _photoStreamImages = eventPictures;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_photoStreamImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Set up cell identifier that matches the Storyboard cell name
    static NSString *identifier = @"Cell";
    PhotoStreamViewCell *cell = (PhotoStreamViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([_photoStreamImages count] !=
        0) {
        cell.imageView.image = _photoStreamImages[indexPath.row];
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PhotoDetailSegue"]) {
        PhotoStreamViewCell *cell = (PhotoStreamViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        PhotoStreamImageViewController *vc = (PhotoStreamImageViewController *)[segue destinationViewController];
        vc.image = _photoStreamImages[indexPath.row];
    }
}

- (IBAction)transitionToCamera:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.currentEventObject = self.eventObject;
    [self performSegueWithIdentifier:@"CameraView" sender:self];
}

@end
