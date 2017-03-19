//
//  XEL_ImagePickerController.h
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/22.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XEL_ImagePickerController : UINavigationController

@property (nonatomic, assign) NSInteger maxImagesCount;

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount;

@end
