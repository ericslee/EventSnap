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
#import "MBProgressHUD.h"

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
    eventPictures = [NSMutableArray array];
    NSMutableArray *eventIds = [NSMutableArray array];
    PFQuery *query = [PFQuery queryWithClassName:@"ImageObject"];
    if (eventPointers.count != 0) {
        for (int i = 0; i < eventPointers.count; i++){
            PFObject *eventPic = [eventPointers objectAtIndex:i];
            PFObject *picObj = [query getObjectWithId:eventPic.objectId];
            PFFile *file = picObj[@"image"];
            [eventIds addObject:eventPic.objectId];
            NSData *data = [file getData];
            UIImage *eventImage = [UIImage imageWithData:data];
            if (!(eventImage ==  nil)){
                [eventPictures addObject:eventImage];
            }
            
        }
        _photoStreamImages = eventPictures;
        _photoStreamIDs = eventIds;
    }
    
    NSDate *todaysDate = [[NSDate alloc] initWithTimeIntervalSinceNow:100000];
    
    
    NSComparisonResult result = [todaysDate compare:self.eventObject[@"event_end_date"]];
    
    if (result == NSOrderedDescending){
        addPhotoLabel.hidden = TRUE;
        NSLog(@"hidden true");
    }
    else {
        addPhotoLabel.hidden = FALSE;
        NSLog(@"hidden false");
    }
    
    //[query whereKey:@"event_start_date" greaterThan:todaysDate];
    
    /*
    // create a UIRefreshControl for reloading the data in the stream with new images
    UI*RefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(refreshTable:)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    */
}

// refreshes the data in the table
- (void)refreshTable:(UIRefreshControl *)refreshControl
{
    /*
     // get new JSON table to pull from
     NSData *profileData = [ESLWebRequestManager dataFromString:NUMBERS_URL];
     _mainModel = [[ESLFunFactDataManager alloc] initWithNSData:profileData];
     
     // reload the table
     [self.tableView reloadData];
     
     // stop the refreshing animation
     [refreshControl endRefreshing];
     
     // animate the MBProgressHUD
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     
     NSData *profileData = [ESLWebRequestManager dataFromString:NUMBERS_URL];
     _mainModel = [[ESLFunFactDataManager alloc] initWithNSData:profileData];
     
     // disable the MBProgressHUD
     [MBProgressHUD hideHUDForView:self.view animated:YES];
     */
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
    
    if ([_photoStreamImages count] != 0) {
        cell.imageView.image = _photoStreamImages[indexPath.row];
        cell.photoObjectID = _photoStreamIDs[indexPath.row];
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
        vc.imageID = _photoStreamIDs[indexPath.row];
        vc.eventObject = self.eventObject;
    }
    [self queryForTable];

    [segue destinationViewController];
}

- (IBAction)transitionToCamera:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.currentEventObject = self.eventObject;
    [self performSegueWithIdentifier:@"CameraView" sender:self];
}


- (void)queryForTable
{
    NSArray *eventPointers = self.eventObject[@"event_pictures"];
    PFQuery *query = [PFQuery queryWithClassName:@"ImageObject"];
    [query orderByAscending:@"createdAt"];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    if (eventPointers.count != 0) {
        for (int i = 0; i < eventPointers.count; i++){
            PFObject *eventPic = [eventPointers objectAtIndex:i];
            PFObject *picObj = [query getObjectWithId:eventPic.objectId];
            PFFile *file = picObj[@"image"];
            [_photoStreamIDs addObject:eventPic.objectId];
            //NSData *data = [file getData];
            //UIImage *eventImage = [UIImage imageWithData:data];
            //[eventPictures addObject:eventImage];
            [dataArray addObject:file];
            
        }
        //_photoStreamImages = eventPictures;
    }
    for (PFFile *object in dataArray) {
        [object getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        // Now that the data is fetched, update the cell's image property with thumbnail
                        
                        NSLog(@"Fetching image..");
                        
                        [_photoStreamImages addObject:[UIImage imageWithData:data]];
                        
                        NSLog(@"Size of the gridImages array: %d", [_photoStreamImages count]);
                        
                    } else {
                        // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
            }
}

@end
