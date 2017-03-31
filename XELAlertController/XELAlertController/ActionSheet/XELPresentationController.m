//
//  XELPresentationController.m
//  XELAlertController
//
//  Created by Tronsis－mac on 17/3/30.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XELPresentationController.h"

@interface XELPresentationController ()
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation XELPresentationController

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return self;
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

//修改被展示view的位置和大小
- (CGRect)frameOfPresentedViewInContainerView {
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
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
