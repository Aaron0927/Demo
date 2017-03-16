//
//  RightDeleteTableViewCell.h
//  XEL_CustomDelete
//
//  Created by Tronsis－mac on 17/3/16.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RightDeleteTableViewCell;

@protocol RightDeleteTableViewCellDelegate <NSObject>

- (void)didDeleteCell:(RightDeleteTableViewCell *)cell;

@end

@interface RightDeleteTableViewCell : UITableViewCell
@property (nonatomic, weak) id<RightDeleteTableViewCellDelegate>delegate;
@end
