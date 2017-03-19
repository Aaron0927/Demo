//
//  XEL_ImagesViewController.m
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/22.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import "XEL_ImagesViewController.h"

#import "XEL_AlbumTool.h"
#import "XEL_AssetCell.h"
#import "XEL_SelectCounterButton.h"

#import "XEL_PreViewController.h"

@interface XEL_ImagesViewController () <XEL_AssetCellDelegate> {
    
    //选中照片的数量
    NSMutableArray *_selectedImagesArray;
    
}

@property (nonatomic, strong) NSArray <PHAsset *>* assetsArray;

@property (nonatomic, strong) XEL_SelectCounterButton *counterButton;
@property (nonatomic, strong) UIBarButtonItem *previewItem;
@property (nonatomic, strong) UIBarButtonItem *originalItem;
@property (nonatomic, strong) UIBarButtonItem *sureItem;

@end

@implementation XEL_ImagesViewController

static NSString * const reuseIdentifier = @"Cell";


- (instancetype)init {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self = [super initWithCollectionViewLayout:flowLayout];
    
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[XEL_AssetCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    _selectedImagesArray = [NSMutableArray array];
    _assetsArray = [[XEL_AlbumTool sharePhotoTool] getAssetsInAssetCollection:_ablum.assetCollection ascending:YES];
    
    [self settingToolBar];
    [self updateCounter];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XEL_AssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PHAsset *asset = _assetsArray[indexPath.row];
    [[XEL_AlbumTool sharePhotoTool] requestImageForAsset:asset size:PHImageManagerMaximumSize resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image) {
        cell.assetImageView.image = image;
    }];
    
    cell.delegate = self;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



- (void)XEL_AssetCell:(XEL_AssetCell *)cell didSelected:(BOOL)isSelected {
    
    //判断是否超过最大选中数量了
    if (_selectedImagesArray.count == _maxImagesCount && isSelected) {
        NSString *message = [NSString stringWithFormat:@"最多只能选择%lu张照片", (unsigned long)_maxImagesCount];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        cell.selectedButton.selected = NO;
        return;
    }
    
    //添加到选中数组中
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    PHAsset *asset = _assetsArray[indexPath.row];
    if (isSelected) {
        [_selectedImagesArray addObject:asset];
    } else {
        [_selectedImagesArray removeObject:asset];
    }
    
    [self updateCounter];
}

- (void)updateCounter {
    if (_selectedImagesArray.count <= 0) {
        [_counterButton setHidden:YES];
        _previewItem.enabled = NO;
        _originalItem.enabled = NO;
        _sureItem.enabled = NO;
    } else {
        
        _counterButton.count = _selectedImagesArray.count;
        
        [_counterButton setHidden:NO];
        _previewItem.enabled = YES;
        _originalItem.enabled = YES;
        _sureItem.enabled = YES;
    }
}

//预览
- (void)preview {
    
    XEL_PreViewController *previewController = [[XEL_PreViewController alloc] init];
    previewController.selectedImagesArray = _selectedImagesArray;
    
    [self.navigationController pushViewController:previewController animated:NO];
    
}

//原图
- (void)originalImage {
    
}

//确定
- (void)sureSelected {
    
}

#pragma mark - setting toolbar
- (void)settingToolBar {
    
    _previewItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStyleDone target:self action:@selector(preview)];
    _previewItem.enabled = NO;
    //计数
    _counterButton = [[XEL_SelectCounterButton alloc] init];
    UIBarButtonItem *counterItem = [[UIBarButtonItem alloc] initWithCustomView:_counterButton];
    
    
     _originalItem = [[UIBarButtonItem alloc] initWithTitle:@"原图" style:UIBarButtonItemStyleDone target:self action:@selector(originalImage)];
    _originalItem.enabled = NO;
    
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
     _sureItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureSelected)];
    _sureItem.enabled = NO;
    
    self.toolbarItems = @[_previewItem, _originalItem, counterItem, fixItem, _sureItem];
}


@end
