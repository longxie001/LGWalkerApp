//
//  UIView+Action.h
//  BOCOP
//
//  Created by walker on 15/8/26.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Action)

- (void)setViewActionWithBlock:(void (^)(void))block;

@end
