//
//  secondViewController.m
//  LGWalkerApp
//
//  Created by walker on 16/5/3.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "secondViewController.h"
#import "threeViewController.h"
#import "ExtensionAlertView.h"
#import "GQGesVCTransition.h"
#import "CustomBackButtonNavController.h"
#import "LGPresentTranstion.h"

@interface secondViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *popSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *coverSwitch;
@property (nonatomic ,strong) UIView *cview;
@property (nonatomic, assign)LGTransitionDirection currentDirection;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic,strong)LGPresentTranstion *transition;

@end

@implementation secondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view disableGQVCTransition];
    
    self.cview =[[UIView alloc]initWithFrame:CGRectMake(200, 200, 200, 200)];
//    self.cview.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.cview];
    _imageV.layer.cornerRadius = 40;
    _imageV.layer.masksToBounds = YES;
    
//    self.view.backgroundColor = [UIColor orangeColor];
}

- (BOOL)navigationShouldPopOnBackButton
{
    [[ExtensionAlertView shareMarager]showAlertViewWithTitle:@"返回" message:@"确定" cancelButtonTitle:@"cancel" otherButtonTitle:@"ok" clickAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    return NO;
}


- (IBAction)back:(id)sender
{
    NSLog(@"---sender");
    threeViewController *vc  = [[threeViewController alloc]init];
    CustomBackButtonNavController *navi = [[CustomBackButtonNavController alloc]initWithRootViewController:vc];
    self.transition = [[LGPresentTranstion alloc]initWithModalViewController:navi];
//    self.transition = [[LGPresentTranstion alloc]init];
    self.transition.popAnimation = self.popSwitch.isOn;
    self.transition.transitionDirection = self.currentDirection;
    self.transition.transitionCover = self.coverSwitch.isOn;
    self.transition.dragable    = YES;
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    navi.transitioningDelegate = self.transition;
    vc.transitionAnimator = self.transition;
    [self presentViewController:navi animated:YES completion:^{
//        self.transition.transitionDirection = kLGTransitionDirectionRight;
    }];
}

- (IBAction)upAction:(id)sender {
    self.currentDirection = kLGTransitionDirectionUp;
}
- (IBAction)downAction:(id)sender {
    self.currentDirection = kLGTransitionDirectionDown;
}

- (IBAction)leftAction:(id)sender {
    self.currentDirection = kLGTransitionDirectionLeft;
}
- (IBAction)rightAction:(id)sender {
    self.currentDirection = kLGTransitionDirectionRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
