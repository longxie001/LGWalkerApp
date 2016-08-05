//
//  LGPresentTranstion.m
//  LGWalkerApp
//
//  Created by walker on 16/7/29.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "LGPresentTranstion.h"

@implementation LGPresentTranstion


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    if (containerView == nil) {
        return;
    }

    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    
    UIView *fromView = [self fromView:transitionContext];
    UIView *toView = [self toView:transitionContext];
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    switch (self.transitionDirection) {
        case kLGTransitionDirectionLeft:
        case kLGTransitionDirectionRight: {
            
            CGFloat transformX = 0;
            if (self.transitionDirection == kLGTransitionDirectionLeft) {
                if (self.transitionMode == kLGTransitionPresent) {
                    transformX = screenWidth;
                }else{
                    transformX = -screenWidth;
                }
            }else{
                if (self.transitionMode == kLGTransitionPresent) {
                    transformX = -screenWidth;
                }else{
                    transformX = screenWidth;
                }
            }
            
            if (self.transitionCover) {
                if (self.transitionMode == kLGTransitionPresent) {
                    toView.transform = CGAffineTransformMakeTranslation(transformX, 0);
                }
                
                if (self.popAnimation) {
                    if (self.transitionMode == kLGTransitionPresent) {
                        [self popAnimation:toView translationX:0 completionBlock:^{
                            [self transtionFinishedFromView:fromView
                                          animateTransition:transitionContext];
                        }];
                    }else{
                        [containerView bringSubviewToFront:fromView];
                        [self popAnimation:fromView translationX:-transformX completionBlock:^{
                            [self transtionFinishedFromView:fromView
                                          animateTransition:transitionContext];
                        }];
                    }
                }else{
                    [UIView animateWithDuration:self.duration animations:^{
                        if (self.transitionMode == kLGTransitionPresent) {
                            toView.transform = CGAffineTransformIdentity;
                        }else{
                            [containerView bringSubviewToFront:fromView];
                            fromView.transform = CGAffineTransformMakeTranslation(-transformX, 0);;
                        }
                    } completion:^(BOOL finished) {
                        [self transtionFinishedFromView:fromView
                                      animateTransition:transitionContext];
                    }];
                }
            }else{
                [containerView bringSubviewToFront:toView];
                toView.transform = CGAffineTransformMakeTranslation(transformX, 0);
                
                if (self.popAnimation) {
                    [self popAnimation:fromView translationX:-transformX completionBlock:nil];
                    [self popAnimation:toView translationX:0 completionBlock:^{
                        [self transtionFinishedFromView:fromView
                                      animateTransition:transitionContext];
                    }];
                }else{
                    [UIView animateWithDuration:self.duration animations:^{
                        fromView.transform = CGAffineTransformMakeTranslation(-transformX, 0);
                        toView.transform   = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        [self transtionFinishedFromView:fromView
                                      animateTransition:transitionContext];
                    }];
                }
            }
            break;
        }
        case kLGTransitionDirectionUp:
        case kLGTransitionDirectionDown: {
            
            CGFloat transformY = 0;
            if (self.transitionDirection == kLGTransitionDirectionUp) {
                if (self.transitionMode == kLGTransitionPresent) {
                    transformY = screenHeight;
                }else{
                    transformY = -screenHeight;
                }
            }else{
                if (self.transitionMode == kLGTransitionPresent) {
                    transformY = -screenHeight;
                    
                }else{
                    transformY = screenHeight;
                }
            }
            
            if (self.transitionCover) {
                if (self.transitionMode == kLGTransitionPresent) {
                    toView.transform = CGAffineTransformMakeTranslation(0, transformY);
                }
                
                if (self.popAnimation) {
                    if (self.transitionMode == kLGTransitionPresent) {
                        [self popAnimation:toView translationY:0 completionBlock:^{
                            [self transtionFinishedFromView:fromView
                                          animateTransition:transitionContext];
                        }];
                    }else{
                        [containerView bringSubviewToFront:fromView];
                        [self popAnimation:fromView translationY:-transformY completionBlock:^{
                            [self transtionFinishedFromView:fromView
                                          animateTransition:transitionContext];

                        }];
                    }
                }else{
                    [UIView animateWithDuration:self.duration animations:^{
                        if (self.transitionMode == kLGTransitionPresent) {
                            toView.transform = CGAffineTransformIdentity;
                        }else{
                            [containerView bringSubviewToFront:fromView];
                            fromView.transform = CGAffineTransformMakeTranslation(0,-transformY);
                        }
                    } completion:^(BOOL finished) {
                        [self transtionFinishedFromView:fromView
                                      animateTransition:transitionContext];
                    }];
                }
            }else{
                [containerView bringSubviewToFront:toView];
                toView.transform = CGAffineTransformMakeTranslation(0,transformY);

                if (self.popAnimation) {
                    [self popAnimation:fromView translationY:-transformY completionBlock:nil];
                    [self popAnimation:toView translationY:0 completionBlock:^{
                        [self transtionFinishedFromView:fromView
                                      animateTransition:transitionContext];
                    }];
                }else{
                    [UIView animateWithDuration:self.duration animations:^{
                        fromView.transform = CGAffineTransformMakeTranslation(0, -transformY);
                        toView.transform   = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        [self transtionFinishedFromView:fromView
                                      animateTransition:transitionContext];
                    }];
                }
            }
            break;
        }
    }
}

- (void)transtionFinishedFromView:(UIView *)fromView
                animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    fromView.transform = CGAffineTransformIdentity;
    [fromView removeFromSuperview];
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}


- (void)popAnimation:(UIView *)view
        translationX:(CGFloat)translationX
     completionBlock:(void (^)(void))completionBlock
{
    POPSpringAnimation *Ani = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
    Ani.toValue = @(translationX);
    
    //[0-20] 弹力 越大则震动幅度越大
    Ani.springBounciness = 12;
    
    //[0-20] 速度 越大则动画结束越快
    Ani.springSpeed = 18;
    
    //摩擦力
//    Ani.dynamicsFriction = 20;
    
    ////拉力
    //fromAni.dynamicsTension = 150;
    //
    ///质量
    //fromAni.dynamicsMass = 5;
    
    [Ani setCompletionBlock:^(POPAnimation *ani, BOOL success) {
        if (completionBlock) {
            completionBlock();
        }
    }];
    [view.layer pop_addAnimation:Ani forKey:@"AniX"];
}

- (void)popAnimation:(UIView *)view
        translationY:(CGFloat)translationY
     completionBlock:(void (^)(void))completionBlock
{
    POPSpringAnimation *Ani = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
    Ani.toValue = @(translationY);
    
    //[0-20] 弹力 越大则震动幅度越大
    Ani.springBounciness = 18;
    
    //[0-20] 速度 越大则动画结束越快
    Ani.springSpeed = 15;
    
    //摩擦力
    Ani.dynamicsFriction = 20;
    
    ////拉力
    //fromAni.dynamicsTension = 150;
    //
    ///质量
    //fromAni.dynamicsMass = 5;
    
    [Ani setCompletionBlock:^(POPAnimation *ani, BOOL success) {
        if (completionBlock) {
            completionBlock();
        }
    }];
    [view.layer pop_addAnimation:Ani forKey:@"AniY"];
}

@end
