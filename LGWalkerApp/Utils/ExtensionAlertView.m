//
//  ExtensionAlertView.m
//  testDemo
//
//  Created by walker on 16/2/26.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "ExtensionAlertView.h"
#import <objc/runtime.h>

@implementation UIView (ActionHandlers)
static char alertKey;
- (void)setActionWithBlock:(void (^)(NSString *))block
{
    objc_setAssociatedObject(self, &alertKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)(NSString *))gethandleAction
{
    return objc_getAssociatedObject(self, &alertKey);
}
@end

@implementation ExtensionAlertView

+ (instancetype)shareMarager
{
    static ExtensionAlertView *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[self class] alloc];
    });
    return m;
}

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelTitle
              otherButtonTitle:(NSString *)buttonTitle
                   clickAction:(void(^)())clickHandler
{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                         message:message
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        if (buttonTitle) {
            [alertVC addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          NSLog(@"UIAlertController - clickHandler");
                                                          if (clickHandler) {
                                                              clickHandler();
                                                          }
                                                      }]];
        }
        if (cancelTitle) {
            [alertVC addAction:[UIAlertAction actionWithTitle:cancelTitle
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * action) {
                                                          NSLog(@"UIAlertController -cancle Button Action Click");
                                                      }]];
        }
        
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title
                                                           message:message
                                                          delegate:[ExtensionAlertView shareMarager]
                                                 cancelButtonTitle:cancelTitle
                                                 otherButtonTitles:buttonTitle, nil];
        
        [alertView setActionWithBlock:clickHandler];
        [alertView show];
    }
}


- (void)showAlertViewWithTextFieldAndTitle:(NSString *)title
                                   message:(NSString *)message
                         cancelButtonTitle:(NSString *)cancelTitle
                          otherButtonTitle:(NSString *)buttonTitle
                      textFieldplaceholder:(NSString *)placeholder
                               clickAction:(void(^)(NSString *))clickHandler
{
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                         message:message
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField * textField) {
            textField.placeholder = placeholder;
        }];
        
        
        if (cancelTitle) {
            [alertVC addAction:[UIAlertAction actionWithTitle:cancelTitle
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * action) {
                                                          NSLog(@"UIAlertController -cancle Button Action Click");
                                                      }]];
        }
        
        if (buttonTitle) {
            [alertVC addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *  action) {
                                                          NSLog(@"UIAlertController - clickHandler");
                                                          if (clickHandler) {
                                                              clickHandler(alertVC.textFields.firstObject.text);
                                                          }
                                                      }]];
        }
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title
                                                           message:message
                                                          delegate:[ExtensionAlertView shareMarager]
                                                 cancelButtonTitle:cancelTitle
                                                 otherButtonTitles:buttonTitle, nil];
        
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *textField = [alertView textFieldAtIndex:0];
        textField.placeholder = placeholder;
        [alertView setActionWithBlock:clickHandler];
        [alertView show];
    }
}

#pragma mark - alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        void (^clickBlock)(NSString *str) = [alertView gethandleAction];
        
        NSString *text = @"";
        if (alertView.alertViewStyle ==UIAlertViewStylePlainTextInput) {
            text = [alertView textFieldAtIndex:0].text;
        }
        if (clickBlock) {
            clickBlock(text);
        }
    }else{
        NSLog(@"cancle Button Action Click");
    }
}

@end




