//
//  AppDelegate.h
//  EventSnap
//
//  Created by Eric Lee on 11/10/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PFObject *currentEventObject;

@end
