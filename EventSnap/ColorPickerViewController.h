//
//  ColorPickerViewController.h
//  EventSnap
//
//  Created by Eric Lee on 12/17/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISColorWheel.h"
#import "EditBannerViewController.h"

@class EditBannerViewController;
@interface ColorPickerViewController : UIViewController <ISColorWheelDelegate>
{
    ISColorWheel* _colorWheel;
    UISlider* _brightnessSlider;
    UIView* _wellView;
}

@property (strong, nonatomic) EditBannerViewController *bannerViewController;
@end
