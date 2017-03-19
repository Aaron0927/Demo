//
//  XEL_AlbumTableViewController.m
//  XEL_ImagePickerController
//
//  Created by Tronsis－mac on 17/2/23.
//  Copyright © 2017年 Json－pc. All rights reserved.
//

#import "XEL_AlbumTableViewController.h"

#import "XEL_ImagesViewController.h"

#import "XEL_AlbumTool.h"

@interface XEL_AlbumTableViewController () {
    
    //选中素材数组
    NSMutableArray <PHAsset *> *_selectedAssets;
    //最多可选照片
    NSInteger _maxImagesCount;
}

@property (nonatomic, strong) NSArray <XEL_AblumList *> *ablumsArray;

@end

static NSString *identifier = @"Cell";

@implementation XEL_AlbumTableViewController

- (instancetype)initWithMaxImagesCount:(NSUInteger)maxImagesCount {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _maxImagesCount = maxImagesCount;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];

    self.tableView.rowHeight = 80;
    [self fetchUserPhotoAuthorization];
    

}


- (void)fetchUserPhotoAuthorization {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusAuthorized:
            [self fetchAssetCollection];
            break;
            
        default:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"访问受限" message:@"请在设置中允许应用获取相册权限" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"前往设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""}  completionHandler:^(BOOL success) {
                    
                }];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:NO];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
            
    }
}

- (void)fetchAssetCollection {
    
    _ablumsArray = [[XEL_AlbumTool sharePhotoTool] getPhotoAlbumList];
    [self.tableView reloadData];
    
    if (_ablumsArray.count > 0) {
        //默认显示第一个相册
        XEL_ImagesViewController *imagesVC = [[XEL_ImagesViewController alloc] init];
        imagesVC.maxImagesCount = _maxImagesCount;
        imagesVC.ablum = _ablumsArray.firstObject;
        [self.navigationController pushViewController:imagesVC animated:NO];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ablumsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    XEL_AblumList *model = _ablumsArray[indexPath.row];
    cell.textLabel.text = model.title;
    [[XEL_AlbumTool sharePhotoTool] requestImageForAsset:model.headImageAsset size:PHImageManagerMaximumSize resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 44)];
        
        imageView.image =image;
        
        [cell.contentView addSubview:imageView];
    }];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XEL_ImagesViewController *imagesVC = [[XEL_ImagesViewController alloc] init];
    imagesVC.maxImagesCount = _maxImagesCount;
    imagesVC.ablum = _ablumsArray[indexPath.row];
    
    [self.navigationController pushViewController:imagesVC animated:NO];
}

@end
