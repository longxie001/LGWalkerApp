//
//  threeViewController.m
//  LGWalkerApp
//
//  Created by walker on 16/7/20.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "threeViewController.h"
#import "fourViewController.h"
#import "UIView+Action.h"


CGFloat const gestureMinimumTranslation = 20.0;

typedef enum : NSInteger{
    
    kPanMoveDirectionNone,
    
    kPanMoveDirectionUp,
    
    kPanMoveDirectionDown,
    
    kPanMoveDirectionRight,
    
    kPanMoveDirectionLeft
    
} kPanMoveDirection;

@interface threeViewController ()
@property (nonatomic,assign)kPanMoveDirection direction;

@end


@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(action:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"next"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(rightaction)];

    self.title = @"三";
    
    [self applyBarTintColorToTheNavigationBar:[UIColor lightGrayColor]];
    
//    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(popAction:)];
//    [gestureRecognizer setTranslation:CGPointMake(40, 0) inView:self.view];
//    [self.view addGestureRecognizer:gestureRecognizer];
    
    self.view.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    [view setViewActionWithBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.transitionAnimator.dragable = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.transitionAnimator.dragable = NO;
}



- (void)popAction:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:self.view];
    if (gesture.state == UIGestureRecognizerStateBegan ){
        _direction = kPanMoveDirectionNone;
    }else if (gesture.state == UIGestureRecognizerStateChanged && _direction == kPanMoveDirectionNone){
        _direction = [self determineCameraDirectionIfNeeded:translation];
        
        // ok, now initiate movement in the direction indicated by the user's gesture
        switch (_direction) {
            case kPanMoveDirectionDown:
                NSLog (@ "Start moving down" );
                break ;
            case kPanMoveDirectionUp:
                NSLog (@ "Start moving up" );
                break ;
            case kPanMoveDirectionRight:
                NSLog (@ "Start moving right" );
                [self action:nil];
                break ;
            case kPanMoveDirectionLeft:
                NSLog (@ "Start moving left" );
                break ;
            default :
                break ;
        }
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        // now tell the camera to stop
        NSLog (@ "Stop" );
    }
}

- (kPanMoveDirection)determineCameraDirectionIfNeeded:(CGPoint)translation
{
    if (_direction != kPanMoveDirectionNone)
        return _direction;
    
    // determine if horizontal swipe only if you meet some minimum velocity
    
    if (fabs(translation.x) > gestureMinimumTranslation)
    {
        BOOL gestureHorizontal = NO;
        if (translation.y == 0.0 )
            gestureHorizontal = YES;
        else
            gestureHorizontal = (fabs(translation.x / translation.y) > 5.0 );
        if (gestureHorizontal)
        {
            if (translation.x > 0.0 )
                return kPanMoveDirectionRight;
            else
                return kPanMoveDirectionLeft;
        }
    }
    
    // determine if vertical swipe only if you meet some minimum velocity
    
    else if (fabs(translation.y) > gestureMinimumTranslation)
    {
        BOOL gestureVertical = NO;
        if (translation.x == 0.0 )
            gestureVertical = YES;
        else
            gestureVertical = (fabs(translation.y / translation.x) > 5.0 );
        if (gestureVertical)
        {
            if (translation.y > 0.0 )
                return kPanMoveDirectionDown;
            else
                return kPanMoveDirectionUp;
        }
    }
    return _direction;
}

- (void)action:(UIBarButtonItem *)sender{
    

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)rightaction
{
    fourViewController *vc = [[fourViewController alloc]init];
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.35;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = @"push";
//    transition.subtype = kCATransitionFromLeft;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

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
