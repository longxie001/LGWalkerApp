//
//  ExtensionAlertView.h
//  testDemo
//
//  Created by walker on 16/2/26.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ActionHandlers)
- (void)setActionWithBlock:(void (^)(NSString *))block;
- (void (^)(NSString *))gethandleAction;
@end

@interface ExtensionAlertView : NSObject <UIAlertViewDelegate>

+ (instancetype)shareMarager;

/**
 *  AlertView无textField
 *
 *  @param title        title
 *  @param message      message
 *  @param cancelTitle  cancelTitle
 *  @param buttonTitle  buttonTitle
 *  @param clickHandler buttonAction
 */
- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelTitle
              otherButtonTitle:(NSString *)buttonTitle
                   clickAction:(void(^)())clickHandler;


/**
 *  AlertView有textField
 *
 *  @param title        title
 *  @param message      message
 *  @param cancelTitle  cancelTitle
 *  @param buttonTitle  buttonTitle
 *  @param placeholder  textFieldPlaceholder
 *  @param clickHandler buttonAction
 */
- (void)showAlertViewWithTextFieldAndTitle:(NSString *)title
                                   message:(NSString *)message
                         cancelButtonTitle:(NSString *)cancelTitle
                          otherButtonTitle:(NSString *)buttonTitle
                      textFieldplaceholder:(NSString *)placeholder
                               clickAction:(void(^)(NSString *))clickHandler;

@end
