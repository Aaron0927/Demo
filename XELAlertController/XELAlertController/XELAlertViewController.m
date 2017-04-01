//
//  XELAlertViewController.m
//  XELAlertController
//
//  Created by Tronsis－mac on 17/4/1.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "XELAlertViewController.h"
#import "UIViewController+XELTransition.h"

@interface XELAlertViewController ()

@end

@implementation XELAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.preferredContentSize = CGSizeMake(300, 190);
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)confirm:(id)sender {
    [self xel_dismissViewControllerCompletion:NULL];
}



@end
