//
//  XEL_PreViewCell.h
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/24.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

//预览图片的cell

#import <UIKit/UIKit.h>

@class XEL_PreViewCell;

@protocol XEL_PreViewCellDelegate <NSObject>

- (void)showNavigationBar:(XEL_PreViewCell *)cell;

@end

@interface XEL_PreViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, weak) id <XEL_PreViewCellDelegate> delegate;


@end
