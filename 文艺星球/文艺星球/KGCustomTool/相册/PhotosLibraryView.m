/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/23
 
 Copyright (c) 2017 My Company
 
 ☆★☆★☆★☆★☆★☆★☆★☆★☆
 ★　　│　心想　│　事成　│　　★
 ☆别╭═╮　　 ╭═╮　　 ╭═╮别☆
 ★恋│人│　　│奎│　　│幸│恋★
 ☆　│氣│　　│哥│　　│福│　☆
 ★　│超│　　│制│　　│滿│　★
 ☆别│旺│　　│作│　　│滿│别☆
 ★恋│㊣│　　│㊣│　　│㊣│恋★
 ☆　╰═╯ 天天╰═╯ 開心╰═╯　☆
 ★☆★☆★☆★☆★☆★☆★☆★☆★.
 
 */

#import "PhotosLibraryView.h"
#import <Photos/Photos.h>
#import "PhotosCell.h"

@interface PhotosLibraryView ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 图片集合 */
@property (nonatomic,strong) NSMutableArray *imageArr;
/** 图片展示 */
@property (nonatomic,strong) UICollectionView *photoList;
/** 图片选择 */
@property (nonatomic,strong) NSMutableArray *chooseArr;
/** 确认按钮 */
@property (nonatomic,strong) UIButton *shureBtu;

@end

@implementation PhotosLibraryViewModel
@end

@implementation PhotosLibraryView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        /** 初始化对象 */
        _imageArr = [NSMutableArray array];
        self.chooseArr = [NSMutableArray array];
        [self requestLibraryPicture];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}
//MARK:--获取本地相册--
- (void)requestLibraryPicture{
    /*获取所有资源的集合，并且按照创件时间排序*/
    PHFetchOptions *options = [[PHFetchOptions alloc]init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]];
    /*获取相机胶卷所有图片*/
    PHFetchResult *assets = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    PHImageRequestOptions *opion = [[PHImageRequestOptions alloc]init];
    /*设置显示模式*/
    opion.resizeMode = PHImageRequestOptionsResizeModeFast;
    opion.synchronous = NO;
    opion.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    /** 获取相册图片，添加到展示视图 */
    __weak typeof(self) mySelf = self;
    for (PHAsset *asset in assets) {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(screenSize.width * scale, screenSize.height * scale) contentMode:PHImageContentModeAspectFit options:opion resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            PhotosLibraryViewModel *model = [PhotosLibraryViewModel new];
            model.image = [UIImage imageWithData:UIImageJPEGRepresentation(result, 0.5)];
            [mySelf.imageArr addObject:model];
            /** 更新视图必须在主线程 */
            dispatch_async(dispatch_get_main_queue(), ^{
                [mySelf.photoList reloadData];
            });
        }];
    }
}
/** 创建瀑布流 */
- (UICollectionView *)photoList{
    if (!_photoList) {
        /** 设置顶部索引 */
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 44);
        layout.itemSize = CGSizeMake((self.bounds.size.width - 8)/3, (self.bounds.size.width - 8)/3);
        _photoList = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:layout];
        _photoList.backgroundColor = [UIColor blackColor];
        _photoList.delegate = self;
        _photoList.dataSource = self;
        [self addSubview:_photoList];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 66)];
        headerView.backgroundColor = [UIColor blackColor];
        [self addSubview:headerView];
        /** 创建取消按钮 */
        UIButton *returnBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        returnBtu.frame = CGRectMake(15, headerView.bounds.size.height - 25, 50, 20);
        [returnBtu setTitle:@"取消" forState:UIControlStateNormal];
        [returnBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        returnBtu.titleLabel.font = [UIFont systemFontOfSize:15];
        [returnBtu addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:returnBtu];
        /** 创建确认按钮 */
        self.shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shureBtu.frame = CGRectMake(headerView.bounds.size.width - 105, headerView.bounds.size.height - 25, 90, 20);
        [self.shureBtu setTitle:@"确认(0)" forState:UIControlStateNormal];
        [self.shureBtu setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        self.shureBtu.titleLabel.font = [UIFont systemFontOfSize:15];
        self.shureBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.shureBtu addTarget:self action:@selector(shureClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.shureBtu];
        
        [_photoList registerNib:[UINib nibWithNibName:@"PhotosCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        
        [_photoList registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    }
    return _photoList;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.imageArr.count > 0) {
        PhotosLibraryViewModel *model = _imageArr[indexPath.row];
        cell.photosImage.image = model.image;
        __block BOOL isShow = NO;
        /** 判断是否选择过，没有显示原图，选择过显示模板 */
        [self.chooseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                isShow = YES;
                *stop = YES;
            }
        }];
        if (isShow == YES) {
            cell.darkView.hidden = NO;
        }else{
            cell.darkView.hidden = YES;
        }
    }
    return cell;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /** 判断是否超出用户给定的最大选择数 */
    if (self.chooseArr.count < self.maxCount) {
        /** 判断是否选择图片 */
        if (self.chooseArr.count > 0) {
            /** 遍历查找是否已经选择 */
            __block BOOL isAdd = YES;
            [self.chooseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                    isAdd = NO;
                    *stop = YES;
                }
            }];
            /** 如果已经选择那么从选择列表删除，否则添加 */
            if (isAdd == YES) {
                [self.chooseArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            }else{
                [self.chooseArr removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            }
        }else{
            /** 如果没有选择图片，那么直接添加 */
            [self.chooseArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.photoList reloadItemsAtIndexPaths:@[path]];
        [self.shureBtu setTitle:[NSString stringWithFormat:@"确认(%ld)",(long)self.chooseArr.count] forState:UIControlStateNormal];
    }else{
        __block BOOL isAdd = YES;
        /** 判断是否已经选择 */
        [self.chooseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                isAdd = NO;
                *stop = YES;
            }
        }];
        /** 如果已经选择，那么删除 */
        if (isAdd == NO) {
            [self.chooseArr removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }
        /** 刷新点击的item */
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.photoList reloadItemsAtIndexPaths:@[path]];
        /** 显示选择的图片数 */
        [self.shureBtu setTitle:[NSString stringWithFormat:@"确认(%ld)",(long)self.chooseArr.count] forState:UIControlStateNormal];
    }
}
/** 头视图点击事件 */
- (void)returnClick{
    self.hidden = YES;
}
/** 确认点击事件 */
- (void)shureClick{
    if (self.chooseImageFromPhotoLibary) {
        /** 先判断是否选择图片 */
        if (self.chooseArr.count > 0) {
            NSMutableArray *sendArr = [NSMutableArray array];
            /** 遍历拿出对应的图片添加到数组 */
            for (NSString *index in self.chooseArr) {
                PhotosLibraryViewModel *model = self.imageArr[[index integerValue]];
                [sendArr addObject:model.image];
            }
            /** 通过block发送到控制器 */
            self.chooseImageFromPhotoLibary(sendArr.copy);
        }
    }
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
