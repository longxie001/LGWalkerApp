/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 UINavigationController subclass used for targeting appearance
  proxy changes in the Custom Back Button example.
 */

#import "CustomBackButtonNavController.h"
#import "LGBaseViewController.h"
#import "JZNavigationExtension.h"


@interface CustomBackButtonNavController()<UIGestureRecognizerDelegate>

@end

@implementation CustomBackButtonNavController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.jz_navigationBarTransitionStyle = JZNavigationBarTransitionStyleDoppelganger;
    self.jz_fullScreenInteractivePopGestureEnabled =YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"showOrHideTabbar"
                                                           object:nil userInfo:@{@"show":@NO}];
    }
}

@end
