//
//  UIUserSettings.h
//  CityGiude
//
//  Created by Dmitry Kuznetsov on 10/11/14.
//  Copyright (c) 2014 Appsgroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface UIUserSettings : NSObject

-(UIPresentationMode)getPresentationMode;
-(void)setPresentationMode:(UIPresentationMode)presentationMode;

-(UIBarButtonItem*)setupRightButtonItem:(UIViewController*)viewController;
-(UIBarButtonItem*)setupBackButtonItem:(UIViewController*)viewController;
-(UIBarButtonItem*)setupFilterButtonItem:(UIViewController*)viewController;
-(UIBarButtonItem*)setupMapMarkerButtonItem:(UIViewController*)viewController;

@end
