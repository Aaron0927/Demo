//
//  XEL_AlbumTool.h
//  XEL_AlbumTool
//
//  Created by xiaoerlong on 2017/2/26.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

//建一个内部类
@interface XEL_AblumList : NSObject

@property (nonatomic, copy) NSString *title;    //相册名字
@property (nonatomic, assign) NSInteger count;  //该相册内相片数量
@property (nonatomic, strong) PHAsset *headImageAsset;  //相册第一张图片的缩略图
@property (nonatomic, strong) PHAssetCollection *assetCollection;   //相册集，通过该属性获取相册集下的所有图片

@end

@interface XEL_AlbumTool : NSObject

+ (instancetype)sharePhotoTool;

///获取用户所有相册列表
- (NSArray <XEL_AblumList *> *)getPhotoAlbumList;

///获取相册内所有图片资源
- (NSArray <PHAsset *> *)getAllAssetInPhotoAlbumWithAscending:(BOOL)ascending;

///获取指定相册内的所有图片
- (NSArray <PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;

///获取每个Asset对应的图片
- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image))completion;

@end
