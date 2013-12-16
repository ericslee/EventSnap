//
//  EditSelectedEventViewController.m
//  EventSnap
//
//  Created by Tara Siegel on 12/9/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "EditSelectedEventViewController.h"
#import <Parse/Parse.h>
#import "EventOrganizersViewController.h"
#import "EditEventInformationViewController.h"
#import "PhotoStreamViewCell.h"
#import "PhotoStreamImageViewController.h"
#import "EditBannerViewController.h"

@interface EditSelectedEventViewController ()

@property (nonatomic, strong) IBOutlet UILabel *eventTitle;
@property (nonatomic, strong) IBOutlet UILabel *eventDate;
@property (nonatomic, strong) IBOutlet UILabel *eventLocation;

@end

@implementation EditSelectedEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //if (self.eventObject == NULL){
        //    [self.navigationController popViewControllerAnimated:YES];
        //}
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.eventTitle.text = self.eventObject[@"event_name"];
    self.eventLocation.text = self.eventObject[@"event_location"];
    self.eventDate.text = [NSString stringWithFormat:@"%@",
                           self.eventObject[@"event_start_date"]];
    
    // Set up event images
    _collectionView.delegate = self;
    
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

- (IBAction)editEventInformation:(id)sender {
   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        EditEventInformationViewController *editInfoViewController = [storyboard instantiateViewControllerWithIdentifier:@"editEventInfo"];
        editInfoViewController.eventObject = self.eventObject;
        [self.navigationController pushViewController:editInfoViewController animated:YES];
}

- (IBAction)editBanners:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditBannerViewController *editBannerViewController = [storyboard instantiateViewControllerWithIdentifier:@"editBanners"];
    editBannerViewController.eventObject = self.eventObject;
    [self.navigationController pushViewController:editBannerViewController animated:YES];
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
    
    if ([_photoStreamImages count] != 0) {
        cell.imageView.image = _photoStreamImages[indexPath.row];
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*if([segue.identifier isEqualToString:@"PhotoDetailSegue"]) {
        PhotoStreamViewCell *cell = (PhotoStreamViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        PhotoStreamImageViewController *vc = (PhotoStreamImageViewController *)[segue destinationViewController];
        vc.image = _photoStreamImages[indexPath.row];
    }*/
    
    if([segue.identifier isEqualToString:@"PhotoDetailSegue"]) {
        PhotoStreamViewCell *cell = (PhotoStreamViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        PhotoStreamImageViewController *vc = (PhotoStreamImageViewController *)[segue destinationViewController];
        vc.image = _photoStreamImages[indexPath.row];
    }
    //[self queryForTable];
    
    [segue destinationViewController];
}

@end
