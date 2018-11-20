//
//  KGArtisticPeopleDetailWorksView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/20.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGArtisticPeopleDetailWorksView.h"
#import "KGAgencyExhibitionDetailCell.h"

@interface KGArtisticPeopleDetailWorksView ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 作品展 */
@property (nonatomic,strong) UICollectionView *worksView;

@end

@implementation KGArtisticPeopleDetailWorksView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KGWhiteColor;
        [self setUpWorksListView];
    }
    return self;
}
/** 创建作品展 */
- (void)setUpWorksListView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.worksView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    self.worksView.backgroundColor = [KGLineColor colorWithAlphaComponent:0.2];
    self.worksView.delegate = self;
    self.worksView.dataSource = self;
    self.worksView.emptyDataSetSource = self;
    self.worksView.emptyDataSetDelegate = self;
    [self addSubview:self.worksView];
    [self.worksView registerNib:[UINib nibWithNibName:@"KGAgencyExhibitionDetailCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"KGAgencyExhibitionDetailCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KGAgencyExhibitionDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KGAgencyExhibitionDetailCell" forIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5,10, 5, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return (CGSize){(KGScreenWidth - 45)/2 ,(KGScreenWidth - 45)/2/330*420+30};
}
// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
