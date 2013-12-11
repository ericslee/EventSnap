//
//  NavigationToAddPhoto.h
//  EventSnap
//
//  Created by Tara Siegel on 12/11/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NavigationToAddPhoto : UINavigationController

@property (nonatomic, strong) PFObject *eventObject;

@end
