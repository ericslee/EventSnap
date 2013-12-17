//
//  EventsListsViewCell.h
//  EventSnap
//
//  Created by Tara Siegel on 12/17/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EventsListsViewCell : UITableViewCell

@property IBOutlet UILabel *titleLabel;
@property IBOutlet UILabel *dateLabel;
@property IBOutlet UILabel *locationLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) PFObject *eventObject;

@end