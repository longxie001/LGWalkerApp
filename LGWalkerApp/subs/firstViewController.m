//
//  firstViewController.m
//  LGWalkerApp
//
//  Created by walker on 16/5/3.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "firstViewController.h"

@interface firstViewController ()
@property (nonatomic,strong)UIView *customView;
@end

@implementation firstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"first";
    
    self.customView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.customView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.customView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self actiop];
}

- (void)actiop
{
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.customView.transform = CGAffineTransformMakeTranslation(0, 200);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.customView.transform = CGAffineTransformIdentity;
        });
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
