//
//  TabBarViewController.m
//  LGWalkerApp
//
//  Created by walker on 16/5/3.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(showOrHide:) name:@"showOrHideTabbar" object:nil];
}

- (void)showOrHide:(NSNotification *)note
{
    BOOL show = [note.userInfo[@"show"] boolValue];
    if (show) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tabBar.transform = CGAffineTransformIdentity;
        }];
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.tabBar.transform = CGAffineTransformTranslate(self.tabBar.transform, 0, 49);
    }];
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
