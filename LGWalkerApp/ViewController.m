//
//  ViewController.m
//  LGWalkerApp
//
//  Created by walker on 16/5/3.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "ViewController.h"
#import "CustomBackButtonNavController.h"
#import <pop/pop.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"showOrHideTabbar"
                                                       object:nil
                                                     userInfo:@{@"show":@YES}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"home";
}

- (IBAction)ViewControllerUnwindSegue:(UIStoryboardSegue *)unwindSegue {
    NSLog(@"unwindSegue");
}

- (IBAction)edit:(id)sender
{
    [self performSegueWithIdentifier:@"homeID" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
