//
//  LGCustomPayView.m
//  LGWalkerApp
//
//  Created by Walker on 16/8/21.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "LGCustomPayView.h"
#import "UIView+Action.h"


static CGFloat LGDetailPayViewHeight = 200.f;
@interface LGDetailPayView ()
@property (nonatomic,copy)void (^cancelAction)();
@end

@implementation LGDetailPayView

- (instancetype)init
{
    if ([super init]) {
        self.frame =CGRectMake(0, LGDetailPayViewHeight, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
        self.backgroundColor = [UIColor redColor];
        [self configView];
    }
    return self;
}

- (void)configView
{
    [self addCancelView];
    [self addDetailView];
}

- (void)addCancelView
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
    label.text = @"cancel";
    label.userInteractionEnabled = YES;
    [label setViewActionWithBlock:^{
        if (self.cancelAction) {
            self.cancelAction();
        }
    }];
    label.backgroundColor = [UIColor whiteColor];
    [self addSubview:label];
}

- (void)addDetailView
{

}

@end


@interface LGCustomPayView ()
@property (nonatomic,strong)LGDetailPayView *detailView;
@end

@implementation LGCustomPayView

- (LGDetailPayView *)detailView
{
    if (!_detailView) {
        _detailView = [[LGDetailPayView alloc]init];
    }
    return _detailView;
}

- (instancetype)init
{
    if ([super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.detailView];
        
        __block typeof(self) weakSelf = self;
        [self.detailView setCancelAction:^{
            [weakSelf dismiss];
        }];
    }
    return self;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

@end
