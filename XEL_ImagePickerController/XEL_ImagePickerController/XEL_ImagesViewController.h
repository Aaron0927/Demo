//
//  XEL_ImagesViewController.h
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/22.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XEL_AlbumTool.h"

@interface XEL_ImagesViewController : UICollectionViewController

@property (nonatomic, assign) NSInteger maxImagesCount;
@property (nonatomic, strong) XEL_AblumList *ablum;


@end
