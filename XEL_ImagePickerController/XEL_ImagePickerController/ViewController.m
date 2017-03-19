//
//  ViewController.m
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/22.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import "ViewController.h"
#import "XEL_ImagePickerController.h"

#import <Photos/Photos.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 30);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"chooseImage" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)chooseImage {
    
    XEL_ImagePickerController *imagePicker = [[XEL_ImagePickerController alloc] initWithMaxImagesCount:3];
    [self presentViewController:imagePicker animated:YES completion:nil];
    //[self getOriginalImages];
    
}

- (void)getOriginalImages {
    
    
    //获取相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
}

- (void)enumerateAssetsInAssetCollection:(PHAssetCollection*)assetCollection original:(BOOL)original {
    
    NSLog(@"相簿名：%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"result:%@\ninfo:%@", result, info);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
