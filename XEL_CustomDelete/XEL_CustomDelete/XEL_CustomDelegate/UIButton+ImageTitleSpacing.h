//
//  UIButton+ImageTitleSpacing.h
//  航海e家
//
//  Created by leijin on 16/5/9.
//  Copyright © 2016年 leijin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop,     //image在上
    MKButtonEdgeInsetsStyleLeft,    //image在左
    MKButtonEdgeInsetsStyleBottom,  //image在下
    MKButtonEdgeInsetsStyleRight    //image在右
};

@interface UIButton (ImageTitleSpacing)

/**
 *  设置button的titlelabel和imageview的布局样式及间距
 *
 *  @param style titlelabel和imageview的布局样式
 *  @param space titlelabel和imageview的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
