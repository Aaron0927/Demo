//
//  WeiBoShareViewController.m
//  XELAlertController
//
//  Created by Tronsis－mac on 17/3/31.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "WeiBoShareViewController.h"
#import "WeiBoShareCollectionViewCell.h"
#import "UIViewController+XELTransition.h"

@interface WeiBoShareViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *secondCollectionView;

@property (nonatomic, strong) NSArray <NSDictionary <UIImage *, NSString *>*> *datasArray;
@property (nonatomic, strong) NSArray <NSDictionary <UIImage *, NSString *>*> *secondDatasArray;

@end

static NSString *identifier = @"cell";

@implementation WeiBoShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.contentSize = CGSizeMake(self.view.frame.size.width, 300);
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WeiBoShareCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    [_secondCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WeiBoShareCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    _datasArray = @[@{@"image":@"50x50", @"title":@"微博"},
                    @{@"image":@"50x50", @"title":@"好友圈"},
                    @{@"image":@"50x50", @"title":@"私信和群"},
                    @{@"image":@"50x50", @"title":@"微信好友"},
                    @{@"image":@"50x50", @"title":@"朋友圈"},
                    @{@"image":@"50x50", @"title":@"支付宝好友"},
                    @{@"image":@"50x50", @"title":@"生活圈"},
                    @{@"image":@"50x50", @"title":@"QQ"},
                    @{@"image":@"50x50", @"title":@"QQ空间"},
                    @{@"image":@"50x50", @"title":@"钉钉"}
                    ];
    _secondDatasArray = @[@{@"image":@"50x50", @"title":@"赋值链接"},
                          @{@"image":@"50x50", @"title":@"返回首页"}
                          ];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _collectionView) {
        return _datasArray.count;
    } else if (collectionView == _secondCollectionView) {
        return 2;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeiBoShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *data;
    if (collectionView == _collectionView) {
        data = _datasArray[indexPath.row];
    } else {
        data = _secondDatasArray[indexPath.row];
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", data[@"image"]]];
    cell.titleLabel.text = data[@"title"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(70, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self xel_dismissViewControllerCompletion:NULL];
}


@end
