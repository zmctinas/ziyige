//
//  albumViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/7/11.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "albumViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "albumCollectionViewCell.h"

@interface albumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)NSMutableArray* imageSource;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation albumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改头像";
    
    [self registercell];
    
    [self.imageSource addObject:[UIImage imageNamed:@"icon_camara"]];
    
    PHFetchResult* result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:[[PHFetchOptions alloc]init]];
    NSLog(@"%ld",result.count);
    for (PHAssetCollection* sub in result) {
        [self enumerateAssetsInAssetCollection:sub original:NO];
    }
    
    [_collectionView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)registercell
{
    UINib* nib = [UINib nibWithNibName:@"albumCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
}

/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
            [self.imageSource addObject:result];
        }];
    }
}

#pragma mark - UICollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    albumCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.iconView.image = self.imageSource[indexPath.row];
    
    return cell;
}

#pragma mark - getter

-(NSMutableArray*)imageSource
{
    if (!_imageSource) {
        _imageSource = [NSMutableArray array];
    }
    return _imageSource;
}

@end
