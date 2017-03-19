//
//  XEL_PreViewCell.m
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/24.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import "XEL_PreViewCell.h"
#import <objc/runtime.h>

@interface XEL_PreViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XEL_PreViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.scrollView];
        [self.scrollView addSubview:self.imageView];
    }
    
    return self;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    NSLog(@"willZoom");
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"didZoom");
    //没有放大的情况下，偏移量为(scrollView.bounds.size.width - scrollView.contentSize.width)/2
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    
    _imageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"endZoom:%f", scale);
//    view.center = scrollView.center;
}


- (void)setImage:(UIImage *)image {
    _image = image;
    
    _imageView.image = image;
    _imageView.center = _scrollView.center;
    CGRect rect = _imageView.frame;
    rect.size.width = self.frame.size.width;
    rect.size.height = self.frame.size.width * (_image.size.height / _image.size.width);
    _imageView.frame = rect;
    
    //_scrollView.contentSize = image.size;
}

- (void)showNavigationBar {
    if (_delegate && [_delegate respondsToSelector:@selector(showNavigationBar:)]) {
        [_delegate showNavigationBar:self];
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.frame.size.width, self.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
        
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNavigationBar)];
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        
    }
    return _imageView;
}


@end
