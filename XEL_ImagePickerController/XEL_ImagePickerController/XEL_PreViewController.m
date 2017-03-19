//
//  XEL_PreViewController.m
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/24.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import "XEL_PreViewController.h"
#import <Photos/Photos.h>

#import "XEL_AlbumTool.h"
#import "XEL_PreViewCell.h"

@interface XEL_PreViewController () <UICollectionViewDataSource, UICollectionViewDelegate, XEL_PreViewCellDelegate> {
    
    BOOL _showNavigationBar;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *identifier = @"Cell";

@implementation XEL_PreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _showNavigationBar = YES;
    
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbar.hidden = YES;
    [self.navigationController.navigationBar setHidden:!_showNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.toolbar.hidden = NO;
    [self.navigationController.navigationBar setHidden:NO];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedImagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XEL_PreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    
    PHAsset *asset = _selectedImagesArray[indexPath.row];
    [[XEL_AlbumTool sharePhotoTool] requestImageForAsset:asset size:PHImageManagerMaximumSize resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image) {
        cell.image = image;

    }];
    
    return cell;
}


- (void)showNavigationBar:(XEL_PreViewCell *)cell {
    _showNavigationBar = !_showNavigationBar;
    [self.navigationController.navigationBar setHidden:_showNavigationBar];
    if (_showNavigationBar) {
        
        self.navigationController.title = [NSString stringWithFormat:@"%ld/%lu", [_collectionView indexPathForCell:cell].row + 1, (unsigned long)_selectedImagesArray.count];
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //CGRect rect = self.view
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[XEL_PreViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}



@end
