//
//  DetialViewController.m
//  LocalStringDemo
//
//  Created by Tronsis－mac on 17/8/16.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "DetialViewController.h"

@interface DetialViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detialLabel;
@property (weak, nonatomic) IBOutlet UILabel *localLabel;

@end

@implementation DetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detialLabel.text = NSLocalizedStringFromTable(@"Detial", @"MyLocal", @"");
    self.localLabel.text = NSLocalizedString(@"Local", @"");
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
