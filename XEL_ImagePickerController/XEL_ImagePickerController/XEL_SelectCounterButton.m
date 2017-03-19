//
//  XEL_SelectCounterButton.m
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/24.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import "XEL_SelectCounterButton.h"

@implementation XEL_SelectCounterButton

- (void)setCount:(NSInteger)count {
    _count = count;
    
    self.hidden = _count <= 0;
    [self setTitle:[NSString stringWithFormat:@"%ld", (long)count] forState:UIControlStateNormal];
    
    //形变
    self.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    //产生阻尼运动的动画
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //恢复形变
        self.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"HMImagePicker.bundle" withExtension:nil];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
        UIImage *image =[UIImage imageNamed:@"number_icon" inBundle:imageBundle compatibleWithTraitCollection:nil];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setTitle:@"0" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.hidden = YES;
        
        CGRect rect = self.frame;
        rect.size = CGSizeMake(20, 20);
        self.frame = rect;
        
        self.userInteractionEnabled = NO;
    }
    return self;
}

@end
