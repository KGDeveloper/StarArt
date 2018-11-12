//
//  KGAgencyExhibitionDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyExhibitionDetailVC.h"
#import "KGAgencyExhibitionDetailCell.h"
#import "KGAgencyExhibitionDetailHeaderView.h"

@interface KGAgencyExhibitionDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 详情 */
@property (nonatomic,strong) UICollectionView *cllectionView;

@end

@implementation KGAgencyExhibitionDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectMake(15, 0, 50, 30) title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    self.view.backgroundColor = KGWhiteColor;

    
    [self setUpCollectionView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 详情页 */
- (void)setUpCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionHeadersPinToVisibleBounds = NO;
    self.cllectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight) collectionViewLayout:layout];
    self.cllectionView.delegate = self;
    self.cllectionView.dataSource = self;
    self.cllectionView.showsVerticalScrollIndicator = NO;
    self.cllectionView.showsHorizontalScrollIndicator = NO;
    self.cllectionView.backgroundColor = KGLineColor;
    if (@available(iOS 11.0, *)) {
        self.cllectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.cllectionView];
    [self.cllectionView registerNib:[UINib nibWithNibName:@"KGAgencyExhibitionDetailCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"KGAgencyExhibitionDetailCell"];
    [self.cllectionView registerNib:[UINib nibWithNibName:@"KGAgencyExhibitionDetailHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KGAgencyExhibitionDetailHeaderView"];
}
/** 代理 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KGAgencyExhibitionDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KGAgencyExhibitionDetailCell" forIndexPath:indexPath];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        KGAgencyExhibitionDetailHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KGAgencyExhibitionDetailHeaderView" forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5,10, 5, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){KGScreenWidth,KGScreenWidth/750*430 + 315};
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
