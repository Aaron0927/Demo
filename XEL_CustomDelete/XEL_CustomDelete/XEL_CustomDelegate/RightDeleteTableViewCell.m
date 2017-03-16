//
//  RightDeleteTableViewCell.m
//  XEL_CustomDelete
//
//  Created by Tronsis－mac on 17/3/16.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "RightDeleteTableViewCell.h"
#import "UIButton+ImageTitleSpacing.h"

@implementation RightDeleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
    [super didTransitionToState:state];
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
                for (UIView *aSubView in subView.subviews) {
                    if ([aSubView isKindOfClass:[UIButton class]]) {
                        //原有的系统button在显示的时候会将文字调整到居中，所以无法设置文字的位置，只能自定义视图
                        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
                        actionButton.frame = aSubView.frame;
                        [actionButton setBackgroundColor:[UIColor redColor]];
                        [actionButton setImage:[UIImage imageNamed:@"rule_delete.png"] forState:UIControlStateNormal];
                        [actionButton.titleLabel setFont: [UIFont fontWithName:@".PingFangSC-Regular" size:15]];
                        [actionButton setTitle:@"删除" forState:UIControlStateNormal];
                        [actionButton addTarget:self action:@selector(deleteCell) forControlEvents:UIControlEventTouchUpInside];
                        [actionButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:13];
                        [subView addSubview:actionButton];
                        [subView bringSubviewToFront:actionButton];
                        break;
                    }
                }
            }
        }
    }
}

- (void)deleteCell {
    if (_delegate && [_delegate respondsToSelector:@selector(didDeleteCell:)]) {
        [_delegate didDeleteCell:self];
    }
}

@end
