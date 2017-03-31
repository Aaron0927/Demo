//
//  UIViewController+XELTransition.m
//  XELAlertController
//
//  Created by Tronsis－mac on 17/3/30.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "UIViewController+XELTransition.h"
#import <objc/runtime.h>

#define APP_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define APP_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

@implementation UIViewController (XELTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //添加方法实现
        SEL originalSelector = @selector(willTransitionToTraitCollection:withTransitionCoordinator:);
        SEL swizzledSelector = @selector(xel_willTransitionToTraitCollection:withTransitionCoordinator:);
        
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        
        BOOL success = class_addMethod([self class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod([self class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)xel_willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    CGSize preferredContentSize = self.contentSize;
    BOOL vertical = newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact; //横屏为YES
    
    if (vertical) {
        //横屏
        preferredContentSize.height = MIN(preferredContentSize.height, APP_SCREEN_WIDTH * 0.8);
    } else {
        //竖屏
        preferredContentSize.height = MIN(preferredContentSize.height, APP_SCREEN_HEIGHT * 0.8);
    }
    
    self.preferredContentSize = preferredContentSize;
    [self xel_willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
}

#pragma mark -
#pragma mark public

- (void)xel_presentViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion {
    XELPresentationController *present = [[XELPresentationController alloc] initWithPresentedViewController:viewControllerToPresent presentingViewController:self];
    if (!viewControllerToPresent.xel_delegateFlag) {
        viewControllerToPresent.transitioningDelegate = present;
        viewControllerToPresent.xel_delegateFlag = YES;
    }
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
}

- (void)xel_dismissViewControllerCompletion:(void (^)(void))completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}


#pragma mark -
#pragma mark setter getter

- (void)setXel_delegateFlag:(BOOL)xel_delegateFlag {
    objc_setAssociatedObject(self, _cmd, @(xel_delegateFlag), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xel_delegateFlag {
    return [objc_getAssociatedObject(self, @selector(setXel_delegateFlag:)) integerValue] == 0 ? NO : YES;
}

- (void)setContentSize:(CGSize)contentSize {
    self.preferredContentSize = contentSize;
    objc_setAssociatedObject(self, _cmd, NSStringFromCGSize(contentSize), OBJC_ASSOCIATION_RETAIN);
}

- (CGSize)contentSize {
    return CGSizeFromString(objc_getAssociatedObject(self, @selector(setContentSize:)));
}


@end
