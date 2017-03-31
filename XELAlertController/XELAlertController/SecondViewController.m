//
//  SecondViewController.m
//  XELAlertController
//
//  Created by Tronsis－mac on 17/3/30.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"
#import "UIViewController+XELTransition.h"



#define CELL_HEIGHT 44

@interface SecondViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UIView *footerView;


@end

 static NSString *identifier = @"cell";

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor greenColor];
    //[self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    self.dataSource = @[@"交易记录",
                        @"支付管理",
                        @"支付安全",
                        @"帮助中心"];
    self.contentSize = CGSizeMake(self.view.frame.size.width, CELL_HEIGHT * self.dataSource.count + CGRectGetHeight(self.footerView.frame));
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self xel_dismissViewControllerCompletion:^{
        self.completion();
    }];
}


//- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
//    [self updatePreferredContentSizeWithTraitCollection:newCollection];
//}

//- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection {
//    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
//}


@end
