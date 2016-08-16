//
//  NSObject+Extension.m
//  LGWalkerApp
//
//  Created by walker on 16/8/15.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

+ (void)load
{
    Method orginalArrayMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method newArrayMethod     = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(lg_addObject:));
    method_exchangeImplementations(orginalArrayMethod, newArrayMethod);
    
    Method orginalDictMethod = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:));
    Method newDictMethod     = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(lg_setObject:forKey:));
     method_exchangeImplementations(orginalDictMethod, newDictMethod);
}

- (void)lg_addObject:(id)object
{
    if (object != nil) {
        [self lg_addObject:object];
    }
}

- (void)lg_setObject:(id)anObject forKey:(NSString *)aKey
{
    if (aKey && anObject) {
        if (aKey!=nil && anObject != nil) {
            [self lg_setObject:anObject forKey:aKey];
        }
    }
}

@end
