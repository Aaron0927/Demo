//
//  LeftTableViewCell.h
//  XEL_CustomDelete
//
//  Created by Tronsis－mac on 17/3/16.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftTableViewCell;

@protocol LeftTableViewCellDelegate <NSObject>

- (void)LeftTableViewCellDidDelete:(LeftTableViewCell *)cell;

@end

@interface LeftTableViewCell : UITableViewCell
@property (nonatomic, weak) id<LeftTableViewCellDelegate>delegate;
@end
