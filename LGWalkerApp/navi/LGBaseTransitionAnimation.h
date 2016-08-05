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


@interface LGBaseTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

/**
 *  The transition animations of pop
 *  duration is invalid
 *  Default  is NO
 */
@property (nonatomic,assign)BOOL popAnimation;

/**
 *  The duration of transition animations
 *  Default is 0.25s
 */
@property (nonatomic,assign)NSTimeInterval duration;

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

-(UIView *)toView:(id<UIViewControllerContextTransitioning>)transitionContext;
-(UIView *)fromView:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
