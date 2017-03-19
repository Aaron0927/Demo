//
//  XEL_AlbumTool.m
//  XEL_AlbumTool
//
//  Created by xiaoerlong on 2017/2/26.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

#import "XEL_AlbumTool.h"


@implementation XEL_AblumList



@end

@implementation XEL_AlbumTool

static XEL_AlbumTool *sharePhotoTool = nil;

+ (instancetype)sharePhotoTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharePhotoTool = [[self alloc] init];
    });
    return sharePhotoTool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharePhotoTool = [super allocWithZone: zone];
    });
    return sharePhotoTool;
}

#pragma mark - 获取所有相册列表
- (NSArray <XEL_AblumList *> *)getPhotoAlbumList {
    
    NSMutableArray<XEL_AblumList *> *photoAlbumList = [NSMutableArray array];
    
    //获取所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray<PHAsset *> *assets = [self getAssetsInAssetCollection:obj ascending:NO];
        if (assets.count > 0) {
            XEL_AblumList *album = [[XEL_AblumList alloc] init];
            album.title = obj.localizedTitle;
            album.count = assets.count;
            album.headImageAsset = assets.firstObject;
            album.assetCollection = obj;
            [photoAlbumList addObject:album];
        }
    }];
    
    //获取用户创建的相册
    PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<PHAsset *> *assets = [self getAssetsInAssetCollection:obj ascending:NO];
        if (assets.count > 0) {
            XEL_AblumList *album = [[XEL_AblumList alloc] init];
            album.title = obj.localizedTitle;
            album.count = assets.count;
            album.headImageAsset = assets.firstObject;
            album.assetCollection = obj;
            [photoAlbumList addObject:album];
        }
    }];
    
    return photoAlbumList.copy;
}

- (PHFetchResult <PHAsset *> *)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    
    return result;
}

#pragma mark - 获取相册内的所有照片资源
- (NSArray<PHAsset *> *)getAllAssetInPhotoAlbumWithAscending:(BOOL)ascending {
    
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creatDate" ascending:ascending]];
    
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:options];
    
    [result enumerateObjectsUsingBlock:^(PHAsset *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:obj];
    }];
    
    return assets.copy;
}

#pragma mark - 获取指定相册的所有图片
- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    
    NSMutableArray <PHAsset *> *arr = [NSMutableArray array];
    
    PHFetchResult *result = [self fetchAssetsInAssetCollection:assetCollection ascending:ascending];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (((PHAsset *)obj).mediaType == PHAssetMediaTypeImage) {
            [arr addObject:obj];
        }
    }];
    
    return arr.copy;
}

#pragma mark - 获取asset对应的图片
- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *))completion {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    /*
        resizeMode:对请求的图像怎样缩放。有三种选择：None：默认加载方式;Fast：尽快的提供接近或者稍微大于要求的尺寸;Exact：精准的提供要求的尺寸
        deliveryMode:图像质量。有三种植：Opportunistic：在速度与质量中均衡;HighQualityFormat：不管花费多长时间，提供高质量图像;FastFormat：以最快速度提供最好质量。
        这个属性只有在 synchronous 为 true 时有效
     */
    options.resizeMode = resizeMode;
    //options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    options.networkAccessAllowed = YES;
    //targetSize 你想要的尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        completion(result);
    }];
}


@end
