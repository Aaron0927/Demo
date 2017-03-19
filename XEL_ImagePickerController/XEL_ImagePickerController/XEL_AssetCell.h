//
//  XEL_AssetCell.h
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/23.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XEL_AssetCellDelegate;

@interface XEL_AssetCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *assetImageView;
@property (nonatomic, strong) UIButton *selectedButton;

//@property (nonatomic, strong) UIImage *assetImage;

@property (nonatomic, weak) id <XEL_AssetCellDelegate> delegate;

@end

@protocol XEL_AssetCellDelegate <NSObject>

- (void)XEL_AssetCell:(XEL_AssetCell *)cell didSelected:(BOOL)isSelected;

@end
