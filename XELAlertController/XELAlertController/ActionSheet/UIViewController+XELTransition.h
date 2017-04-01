//
//  UIViewController+XELTransition.h
//  XELAlertController
//
//  Created by Tronsis－mac on 17/3/30.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XELTransition)
@property (nonatomic, assign) BOOL xel_delegateFlag;
@property (nonatomic, assign) CGSize contentSize;

- (void)xel_presentViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion;

- (void)xel_dismissViewControllerCompletion:(void (^)(void))completion;

@end
