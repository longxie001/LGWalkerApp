//
//  LGBaseAnimation.h
//  LGWalkerApp
//
//  Created by walker on 16/5/4.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LGTransitionMode){
    kLGTransitionPresent,
    kLGTransitionDismiss,
    kLGTransitionPush,
    kLGTransitionPop
};

typedef NS_ENUM(NSInteger,LGTransitionDirection){
    kLGTransitionDirectionLeft,
    kLGTransitionDirectionRight,
    kLGTransitionDirectionUp,
    kLGTransitionDirectionDown
};


@interface LGBaseTransitionAnimation : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,UIGestureRecognizerDelegate>


- (id)initWithModalViewController:(UIViewController *)modalViewController;

/**
 * The transition Spring animation Damping  (0.8)
 * The transition Spring animation Velocity (0.1)
 */
@property (nonatomic) CGFloat Damping;
@property (nonatomic) CGFloat Velocity;

/**
 *  The transition animations of pop
 *  duration is invalid
 *  Default  is NO
 */
@property (nonatomic,assign)BOOL popAnimation;

/**
 *  The duration of transition animations
 *  Default is 0.4
 */
@property (nonatomic,assign)NSTimeInterval transitionDuration;

/**
 *  The transition for Cover TransitionContextFromView
 *  Default is NO
 */
@property (nonatomic,assign)BOOL transitionCover;


/**
 * The transition mode, Only `Present`、`Dismiss`、`Push`、`Pop`.
 * Default is `kLGTransitionPresent`
 */
@property (nonatomic,assign)LGTransitionMode transitionMode;

/**
 *  The transition direction
 *  Default is kLGTransitionDirectionLeft
 */
@property (nonatomic,assign)LGTransitionDirection transitionDirection;

/**
 *  modalViewController can dragable (for Dismiss)
 */
@property (nonatomic, assign, getter=isDragable) BOOL dragable;

/**
 * The transition isInteractive
 */
@property (nonatomic, assign) BOOL isInteractive;


-(UIView *)toView:(id<UIViewControllerContextTransitioning>)transitionContext;
-(UIView *)fromView:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
