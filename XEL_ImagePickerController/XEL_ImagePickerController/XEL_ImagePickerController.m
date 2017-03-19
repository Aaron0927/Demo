//
//  XEL_ImagePickerController.m
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/22.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import "XEL_ImagePickerController.h"
#import "XEL_AlbumTableViewController.h"

@interface XEL_ImagePickerController () {
    NSInteger _maxImagesCount;
    
}

@end

@implementation XEL_ImagePickerController

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount {
    self = [super init];
    if (self) {
        
        _maxImagesCount = maxImagesCount;
        
        //设置根视图
        XEL_AlbumTableViewController *imagesVC = [[XEL_AlbumTableViewController alloc] initWithMaxImagesCount:maxImagesCount];
        [self pushViewController:imagesVC animated:NO];
        
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.toolbarHidden = [viewController isKindOfClass:[XEL_AlbumTableViewController class]];
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    
    self.toolbarHidden = (self.viewControllers.count == 1);
    self.hidesBarsOnTap = NO;
    
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
