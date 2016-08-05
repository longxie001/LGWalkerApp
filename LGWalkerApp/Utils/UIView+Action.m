//
//  UIView+Action.m
//  BOCOP
//
//  Created by walker on 15/8/26.
//
//

#import "UIView+Action.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char kActionHandlerBlockKey;
static char kActionHandlerGestureKey;
@implementation UIView (Action)

- (void)setViewActionWithBlock:(void (^)(void))block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kActionHandlerBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kActionHandlerBlockKey);
        
        if (action) {
            action();
        }
    }
}

@end
