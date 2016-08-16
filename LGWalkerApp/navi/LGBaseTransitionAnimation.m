//
//  LGBaseAnimation.m
//  LGWalkerApp
//
//  Created by walker on 16/5/4.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "LGBaseTransitionAnimation.h"

@interface LGBaseTransitionAnimation ()
@property (nonatomic, strong) UIViewController *modelViewController;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property CGFloat panLocationStart;
@property CATransform3D tempTransform;
@property BOOL bounces;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@end


@implementation LGBaseTransitionAnimation


- (instancetype)init
{
    if (self = [super init]) {
        self.transitionDirection = kLGTransitionDirectionLeft;
        self.transitionMode      = kLGTransitionPresent;
        self.transitionDuration  = 0.4;
        self.popAnimation        = NO;
        self.transitionCover     = NO;
        self.Damping             = 0.8;
        self.Velocity            = 0.1;
        _dragable          = YES;
        _bounces           = NO;
    }
    return self;
}

- (id)initWithModalViewController:(UIViewController *)modalViewController
{
    if ([super init]) {
        self.transitionDirection = kLGTransitionDirectionLeft;
        self.transitionMode      = kLGTransitionPresent;
        self.transitionDuration  = 0.4;
        self.popAnimation        = NO;
        self.transitionCover     = NO;
        self.Damping             = 0.8;
        self.Velocity            = 0.1;
        _dragable          = YES;
        _bounces           = NO;
        _modelViewController = modalViewController;
    }
    return self;
}

- (void)setDragable:(BOOL)dragable
{
    _dragable = dragable;
    if (_dragable) {
        [self removeGestureRecognizerFromModalController];
        if (self.transitionDirection == kLGTransitionDirectionDown) {
            return;
        }
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        self.panGesture.delegate = self;
        [self.modelViewController.view addGestureRecognizer:self.panGesture];
    } else {
        [self removeGestureRecognizerFromModalController];
    }
}

- (void)removeGestureRecognizerFromModalController
{
    if (self.panGesture && [self.modelViewController.view.gestureRecognizers containsObject:self.panGesture]) {
        [self.modelViewController.view removeGestureRecognizer:self.panGesture];
        self.panGesture = nil;
    }
}

# pragma mark -  pan Gesture
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    // Location reference
    CGPoint location = [recognizer locationInView:self.modelViewController.view.window];
    location = CGPointApplyAffineTransform(location, CGAffineTransformInvert(recognizer.view.transform));
    // Velocity reference
    CGPoint velocity = [recognizer velocityInView:[self.modelViewController.view window]];
    velocity = CGPointApplyAffineTransform(velocity, CGAffineTransformInvert(recognizer.view.transform));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.isInteractive = YES;
        if (self.transitionDirection == kLGTransitionDirectionUp) {
            self.panLocationStart = location.y;
        } else {
            self.panLocationStart = location.x;
        }
        [self.modelViewController dismissViewControllerAnimated:YES completion:nil];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat animationRatio = 0;
        
        if (self.transitionDirection == kLGTransitionDirectionUp) {
            animationRatio = (location.y - self.panLocationStart) / (CGRectGetHeight([self.modelViewController view].bounds));
        } else if (self.transitionDirection == kLGTransitionDirectionRight) {
            animationRatio = (self.panLocationStart - location.x) / (CGRectGetWidth([self.modelViewController view].bounds));
        } else if (self.transitionDirection == kLGTransitionDirectionLeft) {
            animationRatio = (location.x - self.panLocationStart) / (CGRectGetWidth([self.modelViewController view].bounds));
        }
        
        [self updateInteractiveTransition:animationRatio];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGFloat velocityForSelectedDirection;
        
        if (self.transitionDirection == kLGTransitionDirectionUp) {
            velocityForSelectedDirection = velocity.y;
        } else {
            velocityForSelectedDirection = velocity.x;
        }
        
        if (velocityForSelectedDirection > 100
            && (self.transitionDirection == kLGTransitionDirectionLeft
                || self.transitionDirection == kLGTransitionDirectionUp)) {
                [self finishInteractiveTransition];
            } else if (velocityForSelectedDirection < -100 && self.transitionDirection == kLGTransitionDirectionRight) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        self.isInteractive = NO;
    }

}

#pragma mark - Utils

- (BOOL)isPriorToIOS8
{
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"8.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending) {
        // OS version >= 8.0
        return YES;
    }
    return NO;
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
#ifdef DEBUG
    NSLog(@"Subclass must override it if you want to make it works well.");
#endif
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    // Reset to our default state
    self.isInteractive = NO;
    self.transitionContext = nil;
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

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    // Return nil if we are not interactive
    if (self.transitionDirection == kLGTransitionDirectionDown) {
        return nil;
    }
    
    if (self.isInteractive && self.dragable) {
        self.transitionMode = kLGTransitionDismiss;
        return self;
    }
    return nil;
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

-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (![self isPriorToIOS8]) {
        toViewController.view.layer.transform = CATransform3DScale(toViewController.view.layer.transform, 1, 1, 1);
    }
    
    self.tempTransform = toViewController.view.layer.transform;
    
    toViewController.view.alpha = 1;
    
    if (fromViewController.modalPresentationStyle == UIModalPresentationFullScreen) {
        [[transitionContext containerView] addSubview:toViewController.view];
    }
    [[transitionContext containerView] bringSubviewToFront:fromViewController.view];
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    if (!self.bounces && percentComplete < 0) {
        percentComplete = 0;
    }
    
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CATransform3D transform = CATransform3DMakeScale(
                                                     1 + (((1 / 1) - 1) * percentComplete),
                                                     1 + (((1 / 1) - 1) * percentComplete), 1);
    toViewController.view.layer.transform = CATransform3DConcat(self.tempTransform, transform);
    
    toViewController.view.alpha = 1 + ((1 - 1) * percentComplete);
    
    CGRect updateRect;
    if (self.transitionDirection == kLGTransitionDirectionUp) {
        updateRect = CGRectMake(0,
                                (CGRectGetHeight(fromViewController.view.bounds) * percentComplete),
                                CGRectGetWidth(fromViewController.view.frame),
                                CGRectGetHeight(fromViewController.view.frame));
    } else if (self.transitionDirection == kLGTransitionDirectionRight) {
        updateRect = CGRectMake(-(CGRectGetWidth(fromViewController.view.bounds) * percentComplete),
                                0,
                                CGRectGetWidth(fromViewController.view.frame),
                                CGRectGetHeight(fromViewController.view.frame));
    } else if (self.transitionDirection == kLGTransitionDirectionLeft) {
        updateRect = CGRectMake(CGRectGetWidth(fromViewController.view.bounds) * percentComplete,
                                0,
                                CGRectGetWidth(fromViewController.view.frame),
                                CGRectGetHeight(fromViewController.view.frame));
    }
    
    // reset to zero if x and y has unexpected value to prevent crash
    if (isnan(updateRect.origin.x) || isinf(updateRect.origin.x)) {
        updateRect.origin.x = 0;
    }
    if (isnan(updateRect.origin.y) || isinf(updateRect.origin.y)) {
        updateRect.origin.y = 0;
    }
    
    CGPoint transformedPoint = CGPointApplyAffineTransform(updateRect.origin, fromViewController.view.transform);
    updateRect = CGRectMake(transformedPoint.x, transformedPoint.y, updateRect.size.width, updateRect.size.height);
    
    fromViewController.view.frame = updateRect;
}

- (void)finishInteractiveTransition
{
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect endRect;
    
    if (self.transitionDirection == kLGTransitionDirectionUp) {
        endRect = CGRectMake(0,
                             CGRectGetHeight(fromViewController.view.bounds),
                             CGRectGetWidth(fromViewController.view.frame),
                             CGRectGetHeight(fromViewController.view.frame));
    } else if (self.transitionDirection == kLGTransitionDirectionRight) {
        endRect = CGRectMake(-CGRectGetWidth(fromViewController.view.bounds),
                             0,
                             CGRectGetWidth(fromViewController.view.frame),
                             CGRectGetHeight(fromViewController.view.frame));
    } else if (self.transitionDirection == kLGTransitionDirectionLeft) {
        endRect = CGRectMake(CGRectGetWidth(fromViewController.view.bounds),
                             0,
                             CGRectGetWidth(fromViewController.view.frame),
                             CGRectGetHeight(fromViewController.view.frame));
    }
    
    CGPoint transformedPoint = CGPointApplyAffineTransform(endRect.origin, fromViewController.view.transform);
    endRect = CGRectMake(transformedPoint.x, transformedPoint.y, endRect.size.width, endRect.size.height);
    
    if (fromViewController.modalPresentationStyle == UIModalPresentationCustom) {
        [toViewController beginAppearanceTransition:YES animated:YES];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGFloat scaleBack = (1 / 1);
                         toViewController.view.layer.transform = CATransform3DScale(self.tempTransform, scaleBack, scaleBack, 1);
                         toViewController.view.alpha = 1.0f;
                         fromViewController.view.frame = endRect;
                     } completion:^(BOOL finished) {
                         if (fromViewController.modalPresentationStyle == UIModalPresentationCustom) {
                             [toViewController endAppearanceTransition];
                         }
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)cancelInteractiveTransition
{
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    [transitionContext cancelInteractiveTransition];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toViewController.view.layer.transform = self.tempTransform;
                         toViewController.view.alpha = 1;
                         
                         fromViewController.view.frame = CGRectMake(0,0,
                                                                    CGRectGetWidth(fromViewController.view.frame),
                                                                    CGRectGetHeight(fromViewController.view.frame));
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:NO];
                         if (fromViewController.modalPresentationStyle == UIModalPresentationFullScreen) {
                             [toViewController.view removeFromSuperview];
                         }
                     }];
}


#pragma mark - transitionContext

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
