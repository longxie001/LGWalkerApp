//
//  LGBaseViewController.m
//  LGWalkerApp
//
//  Created by walker on 16/5/3.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "LGBaseViewController.h"
#import "CustomBackButtonNavController.h"
#import "GQGesVCTransition.h"

@interface LGBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImage *backButtonBackgroundImage = [UIImage imageNamed:@"Menu"];
    // The background should be pinned to the left and not stretch.
    backButtonBackgroundImage = [backButtonBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backButtonBackgroundImage.size.width - 1, 0, 0)];
    
    id appearance;
    if ([[UIDevice currentDevice].systemVersion integerValue]>=9) {
        appearance = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[CustomBackButtonNavController class]]];
    }else{
#if chang
        appearance = [UIBarButtonItem appearanceWhenContainedIn:[CustomBackButtonNavController class], nil];
#endif
    }
    [appearance setBackButtonBackgroundImage:backButtonBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:NULL];
    self.navigationItem.backBarButtonItem = backBarButton;
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self applyBarTintColorToTheNavigationBar:[UIColor redColor]];
}


- (BOOL)navigationShouldPopOnBackButton
{
    return YES;
}

- (void)applyBarTintColorToTheNavigationBar:(UIColor *)color
{
    UIColor *barTintColor = color;
    UIColor *darkendBarTintColor = color;
    id navigationBarAppearance = self.navigationController.navigationBar;
    
    [navigationBarAppearance setBarTintColor:darkendBarTintColor];
    
    [self.navigationController.toolbar setBarTintColor:barTintColor];
    self.navigationController.toolbar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
