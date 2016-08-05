//
//  LGBaseViewController.h
//  LGWalkerApp
//
//  Created by walker on 16/5/3.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+BackButtonHandler.h"

@interface LGBaseViewController : UIViewController

- (BOOL)navigationShouldPopOnBackButton;
- (void)applyBarTintColorToTheNavigationBar:(UIColor *)color;
@end
