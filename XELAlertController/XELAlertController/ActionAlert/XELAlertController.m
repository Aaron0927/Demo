//
//  XELAlertController.m
//  XELAlertController
//
//  Created by Tronsis－mac on 17/3/31.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XELAlertController.h"

@interface XELAlertController () <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation XELAlertController

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

#pragma mark -
#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return transitionContext.isAnimated ? 1.f : 0.f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toView];
    
    CGRect __unused initialFromViewControllerFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect finalFromViewControllerFrame = [transitionContext finalFrameForViewController:fromViewController];
    CGRect initialToViewControllerFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect finalToViewControllerFrame = [transitionContext finalFrameForViewController:toViewController];
    
    BOOL isPresenting = (fromViewController == toViewController.presentingViewController);
    
    if (isPresenting) {
        initialToViewControllerFrame.size = toViewController.preferredContentSize;
        initialToViewControllerFrame.origin.x = (CGRectGetWidth(containerView.frame) - toViewController.preferredContentSize.width) * 0.5;
        initialToViewControllerFrame.origin.y = CGRectGetMinY(containerView.frame) - toViewController.preferredContentSize.height;
        toView.frame = initialToViewControllerFrame;
        
    } else {
        finalFromViewControllerFrame.origin.y = CGRectGetMaxY(containerView.frame);
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isPresenting) {
            toView.frame = finalToViewControllerFrame;
        } else {
            fromView.frame = finalFromViewControllerFrame;
        }
        
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

#pragma mark -
#pragma mark override

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    dimmingView.backgroundColor = [UIColor blackColor];
    dimmingView.opaque = NO;
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
    self.dimmingView = dimmingView;
    [self.containerView addSubview:dimmingView];
    
    id<UIViewControllerTransitionCoordinator>coordinator = self.presentingViewController.transitionCoordinator;
    
    self.dimmingView.alpha = 0.f;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.5f;
    } completion:NULL];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        self.dimmingView = nil;
    }
}

- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator>coordinator = self.presentingViewController.transitionCoordinator;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        self.dimmingView = nil;
    }
}

#pragma mark -
#pragma mark Layout

//确定被展示view的位置和大小
- (CGRect)frameOfPresentedViewInContainerView {
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.size.width = presentedViewContentSize.width;
    presentedViewControllerFrame.origin.y = (CGRectGetHeight(containerViewBounds) - presentedViewContentSize.height ) * 0.5;
    presentedViewControllerFrame.origin.x = (CGRectGetWidth(containerViewBounds) - presentedViewContentSize.width) * 0.5;
    return presentedViewControllerFrame;
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    if (container == self.presentedViewController) {
        return ((UIViewController *)container).preferredContentSize;
    }
    return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController) {
        [self.containerView setNeedsLayout];
    }
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = self.frameOfPresentedViewInContainerView;
}


#pragma mark -
#pragma mark dimmingViewTapped

- (void)dimmingViewTapped:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
