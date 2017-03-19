//
//  XEL_AssetCell.m
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/23.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import "XEL_AssetCell.h"

@interface XEL_AssetCell ()



@end

@implementation XEL_AssetCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.assetImageView];
        [self.contentView addSubview:self.selectedButton];
        
    }
    return self;
}

- (void)selectedImage:(UIButton *)selectedButton {
    selectedButton.selected = !selectedButton.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(XEL_AssetCell:didSelected:)]) {
        [_delegate XEL_AssetCell:self didSelected:selectedButton.selected];
    }
}

#pragma mark - lazy init
- (UIImageView *)assetImageView {
    if (!_assetImageView) {
        _assetImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        
    }
    return _assetImageView;
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        
        _selectedButton = [[UIButton alloc] init];
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"HMImagePicker.bundle" withExtension:nil];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        
        UIImage *selectedImage = [UIImage imageNamed:@"check_box_right" inBundle:imageBundle compatibleWithTraitCollection:nil];
        [_selectedButton setImage:selectedImage forState:UIControlStateSelected];
        
        UIImage *normalImage = [UIImage imageNamed:@"check_box_default" inBundle:imageBundle compatibleWithTraitCollection:nil];
        [_selectedButton setImage:normalImage forState:UIControlStateNormal];
        
        [_selectedButton sizeToFit];
        
        CGFloat dx = self.contentView.frame.size.width - _selectedButton.frame.size.width;
        _selectedButton.frame = CGRectOffset(_selectedButton.bounds, dx, 0);
        
        [_selectedButton addTarget:self action:@selector(selectedImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _selectedButton;
}

@end
