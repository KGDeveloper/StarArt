//
//  KGAgencyDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/9.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyDetailVC.h"
#import "KGAgencyDetailTableViewCell.h"

@interface KGAgencyDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *listView;
/** 顶部滚动图 */
@property (nonatomic,strong) UIScrollView *topScrollView;
/** 页码 */
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation KGAgencyDetailVC

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
    
    [self setUpListView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
// MARK: --创建机构列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setUpTopScrollView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.listView];
 
    [self.listView registerNib:[UINib nibWithNibName:@"KGAgencyDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyDetailTableViewCell"];
}
/** 头视图 */
- (UIView *)setUpTopScrollView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    /** 轮播图 */
    self.topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/75*47)];
    self.topScrollView.delegate = self;
    self.topScrollView.backgroundColor = KGLineColor;
    self.topScrollView.contentSize = CGSizeMake(KGScreenWidth*3, KGScreenWidth/75*47);
    self.topScrollView.bounces = NO;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    [topView addSubview:self.topScrollView];
    /** 页码 */
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(15, KGScreenWidth/75*47 - 22, KGScreenWidth, 7)];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = KGBlueColor;
    self.pageControl.pageIndicatorTintColor = KGWhiteColor;
    [topView addSubview:self.pageControl];
    /** 标签 */
    NSArray *imageArr = @[[UIImage imageNamed:@"定位"],[UIImage imageNamed:@"电话"],[UIImage imageNamed:@"时间"]];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, KGScreenWidth/75*47 + 15 + 30*i, 15, 15)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = imageArr[i];
        [topView addSubview:imageView];
    }
    return topView;
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGAgencyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyDetailTableViewCell" forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.topScrollView) {
        self.pageControl.currentPage = scrollView.contentOffset.x/KGScreenWidth;
    }
}
/** 创建图片 */
- (void)setImageView{
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KGScreenWidth * i, 0, KGScreenWidth, KGScreenWidth/75*47)];
        imageView.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255 green:(arc4random()%255)/255 blue:(arc4random()%255)/255 alpha:1];
        [self.topScrollView addSubview:imageView];
    }
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
