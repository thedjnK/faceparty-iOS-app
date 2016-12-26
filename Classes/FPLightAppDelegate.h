//
//  TestyAppDelegate.h
//  Faceparty Light
//
//  Created by thedjnK on 17/08/2010.
//  Copyright © 2010, todo. All rights reserved.

#import <UIKit/UIKit.h>

//@class TestyViewController;
@class FPLightViewController;

@interface FPLightAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FPLightViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FPLightViewController *viewController;


@end

