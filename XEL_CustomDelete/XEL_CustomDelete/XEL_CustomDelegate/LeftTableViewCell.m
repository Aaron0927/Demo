//
//  LeftTableViewCell.m
//  XEL_CustomDelete
//
//  Created by Tronsis－mac on 17/3/16.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
    if ((state & UITableViewCellStateShowingEditControlMask) == UITableViewCellStateShowingEditControlMask) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellEditControl")]) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDelete)];
                for (UIView *aSubView in subView.subviews) {
                    aSubView.userInteractionEnabled = YES;
                    [aSubView addGestureRecognizer:tap];
                }
                //使用自定义视图时会闪一下
                //                UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
                //                customButton.frame = subView.frame;
                //                [customButton setBackgroundColor:[UIColor whiteColor]];
                //                [customButton setImage:[UIImage imageNamed:@"leftlist_delete"] forState:UIControlStateNormal];
                //                [customButton addTarget:self action:@selector(deleteCell) forControlEvents:UIControlEventTouchUpInside];
                //                [subView addSubview:customButton];
                //                [subView bringSubviewToFront:customButton];
                break;
            }
        }
    }
}

- (void)tapToDelete {
    if (_delegate && [_delegate respondsToSelector:@selector(LeftTableViewCellDidDelete:)]) {
        [_delegate LeftTableViewCellDidDelete:self];
    }
}

@end
