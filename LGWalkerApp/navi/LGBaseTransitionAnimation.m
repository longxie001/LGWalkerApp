//
//  LGBaseAnimation.m
//  LGWalkerApp
//
//  Created by walker on 16/5/4.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "LGBaseTransitionAnimation.h"

@interface LGBaseTransitionAnimation ()
@end


@implementation LGBaseTransitionAnimation


- (instancetype)init
{
    if (self = [super init]) {
        self.transitionDirection = kLGTransitionDirectionLeft;
        self.transitionMode      = kLGTransitionPresent;
        self.duration            = 0.25;
        self.popAnimation        = NO;
        self.transitionCover     = NO;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
#ifdef DEBUG
    NSLog(@"Subclass must override it if you want to make it works well.");
#endif
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transitionMode = kLGTransitionPresent;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transitionMode = kLGTransitionDismiss;
    return self;
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (UINavigationControllerOperationPush == operation) {
        self.transitionMode = kLGTransitionPush;
    } else if (operation == UINavigationControllerOperationPop) {
        self.transitionMode = kLGTransitionPop;
        toVC.navigationController.delegate = nil;
    }
    return self;
}


#pragma mark -

- (UIView *)fromView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    CGRect rect = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = rect;
    return fromView;
}


- (UIView *)toView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    CGRect rect = [transitionContext finalFrameForViewController:toVC];
    toView.frame = rect;
    return toView;
}


@end
