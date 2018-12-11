//
//  KGInstitutionVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/8.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionVC.h"
#import "KGAgencyHomePageVC.h"
#import "KGInstitutionDramaVC.h"
#import "KGAgencyHomePageCell.h"
#import "KGAgencyDetailVC.h"
#import "KGInstitutionDramaDetailVC.h"
#import "KGInstitutionMoviesDetailVC.h"

@interface KGInstitutionVC ()<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 底部加载 */
@property (nonatomic,strong) UIScrollView *backScroll;
/** 顶部滚动 */
@property (nonatomic,strong) UIScrollView *topScroll;
/** 搜索感兴趣场馆 */
@property (nonatomic,strong) UITextField *searchTF;
/** 页数 */
@property (nonatomic,strong) UIPageControl *pageCol;
/** 近期热门 */
@property (nonatomic,strong) UIScrollView *hotScroll;
/** 最新活动 */
@property (nonatomic,strong) UIScrollView *newsScroll;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSArray *topListArr;
@property (nonatomic,strong) NSArray *lowListArr;
/** 搜索页面 */
@property (nonatomic,strong) KGInstitutionSearchView *searchView;
@property (nonatomic,copy) NSString *mohuStr;

@end

@implementation KGInstitutionVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGBlueColor controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    
    self.view.backgroundColor = KGWhiteColor;
    self.title = @"机构";
    
    [self requestData];
    [self requestAdvertising];
    [self setUpListView];
}
/** 首页请求数据 */
- (void)requestData{
    __block NSString *cityId = nil;
    __weak typeof(self) weakSelf = self;
    [[KGRequest shareInstance] userLocationCity:^(NSString * _Nonnull city) {
        if ([city isEqualToString:@"北京市"]) {
            cityId = @"1";
        }else if ([city isEqualToString:@"天津市"]){
            cityId = @"43";
        }else if ([city isEqualToString:@"西安市"]){
            cityId = @"54";
        }else if ([city isEqualToString:@"广州市"]){
            cityId = @"28";
        }else if ([city isEqualToString:@"成都市"]){
            cityId = @"65";
        }else if ([city isEqualToString:@"上海市"]){
            cityId = @"13";
        }else if ([city isEqualToString:@"深圳市"]){
            cityId = @"36";
        }else{
            cityId = @"1";
        }
        [weakSelf requestWithCity:cityId];
    }];
}
/** 请求 */
- (void)requestWithCity:(NSString *)cityID{
    __weak typeof(self) weakSelf = self;
    [[KGRequest shareInstance] requestYourLocation:^(CLLocationCoordinate2D location) {
        [weakSelf requestWithLocation:location city:cityID];
    }];
}
/** 请求数据 */
- (void)requestWithLocation:(CLLocationCoordinate2D)location city:(NSString *)cityID{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectCommunityPlaceHome parameters:@{@"cityID":cityID,@"userLongitude":@(location.longitude),@"userLatitude":@(location.latitude)} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            weakSelf.lowListArr = dic[@"exhibitionList"];
        }
        [weakSelf.listView reloadData];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 请求广告 */
- (void)requestAdvertising{
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectEightFood parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                weakSelf.topListArr = tmp.copy;
            }
        }
        [weakSelf setScrollView];
    } fail:^(NSError * _Nonnull error) {
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建ui */
- (UIView *)setUI{
    self.backScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 420)];
    self.backScroll.backgroundColor = KGWhiteColor;
    self.backScroll.contentSize = CGSizeMake(KGScreenWidth, 420);
    self.backScroll.showsVerticalScrollIndicator = NO;
    self.backScroll.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.backScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.backScroll.bounces = NO;
    [self.view addSubview:self.backScroll];
    
    /** 蓝色背景 */
    UIView *backBlue = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 175)];
    backBlue.backgroundColor = KGBlueColor;
    [self.backScroll addSubview:backBlue];
    /** 搜索框 */
    UIButton *searchBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtu.frame = CGRectMake(15,25, KGScreenWidth - 30, 30);
    [searchBtu setTitle:@"搜索喜欢的场馆" forState:UIControlStateNormal];
    [searchBtu setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    [searchBtu setTitleColor:KGWhiteColor forState:UIControlStateNormal];
    searchBtu.titleLabel.font = KGFontSHRegular(12);
    searchBtu.layer.cornerRadius = 15;
    searchBtu.layer.masksToBounds = YES;
    searchBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [searchBtu addTarget:self action:@selector(searchHoistryData) forControlEvents:UIControlEventTouchUpInside];
    [self.backScroll addSubview:searchBtu];
    /** 顶部滚动图 */
    self.topScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10,65, KGScreenWidth - 20 , 120)];
    self.topScroll.contentSize = CGSizeMake((KGScreenWidth - 20)*5, 120);
    self.topScroll.showsVerticalScrollIndicator = NO;
    self.topScroll.showsHorizontalScrollIndicator = NO;
    self.topScroll.delegate = self;
    self.topScroll.pagingEnabled = YES;
    self.topScroll.bounces = NO;
    self.topScroll.layer.cornerRadius = 5;
    self.topScroll.layer.masksToBounds = YES;
    [self.backScroll addSubview:self.topScroll];
    
    /** 页码 */
    self.pageCol = [[UIPageControl alloc]initWithFrame:CGRectMake(0,165, KGScreenWidth, 5)];
    self.pageCol.numberOfPages = 5;
    self.pageCol.currentPage = 0;
    self.pageCol.pageIndicatorTintColor = KGWhiteColor;
    self.pageCol.currentPageIndicatorTintColor = KGBlueColor;
    [self.backScroll addSubview:self.pageCol];
    /** 选择机构类型 */
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 345, 190)];
    backView.center = CGPointMake(KGScreenWidth/2, 270);
    backView.backgroundColor = KGWhiteColor;
    backView.layer.cornerRadius = 5;
    backView.layer.borderColor = KGLineColor.CGColor;
    backView.layer.borderWidth = 1;
    backView.layer.masksToBounds = YES;
    [self.backScroll addSubview:backView];
    /** 点击按钮 */
    NSArray *imageArr = @[[UIImage imageNamed:@"meishu"],[UIImage imageNamed:@"sheji"],[UIImage imageNamed:@"sheying"],[UIImage imageNamed:@"xiju"],[UIImage imageNamed:@"dianying"],[UIImage imageNamed:@"yinyue"],[UIImage imageNamed:@"meishi"],[UIImage imageNamed:@"juyuan"]];
    NSArray *titleArr = @[@"美术",@"设计",@"摄影",@"戏剧",@"电影",@"音乐",@"美食",@"剧院"];
    for (int i = 0; i < 8; i++) {
        if (i < 4) {
            [backView addSubview:[self createWtihFrame:CGRectMake(((345 - 320)/3 + 80)*i, 0, 80, 80) title:titleArr[i] image:imageArr[i] tag:999+i]];
        }else{
            [backView addSubview:[self createWtihFrame:CGRectMake(((345 - 320)/3 + 80)*(i-4), 90, 80, 80) title:titleArr[i] image:imageArr[i] tag:999+i]];
        }
    }
    /** 近期热门 */
    UILabel *hotLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 395, KGScreenWidth - 30, 15)];
    hotLab.textColor = KGBlackColor;
    hotLab.text = @"近期热门";
    hotLab.font = KGFontSHBold(15);
    [self.backScroll addSubview:hotLab];
//    /** 最新活动 */
//    UILabel *newsLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 545 + KGRectNavAndStatusHight, KGScreenWidth - 30, 15)];
//    newsLab.textColor = KGBlackColor;
//    newsLab.text = @"最新活动";
//    newsLab.font = KGFontSHBold(15);
//    [self.backScroll addSubview:newsLab];
//    /** 热门滚动 */
//    self.hotScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 425 + KGRectNavAndStatusHight, KGScreenWidth - 15 , 100)];
//    self.hotScroll.contentSize = CGSizeMake(540, 100);
//    self.hotScroll.showsVerticalScrollIndicator = NO;
//    self.hotScroll.showsHorizontalScrollIndicator = NO;
//    self.hotScroll.pagingEnabled = YES;
//    self.hotScroll.bounces = NO;
//    [self.backScroll addSubview:self.hotScroll];
//    for (int i = 0; i < 5; i++) {
//        [self.hotScroll addSubview:[self createImageAndTitleWithFrame:CGRectMake(110*i, 0, 100, 100) title:@"你好啊" image:nil tag:1999+i]];
//    }
//    /** 活动滚动 */
//    self.newsScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 575 + KGRectNavAndStatusHight, KGScreenWidth - 15 , 100)];
//    self.newsScroll.contentSize = CGSizeMake(540, 100);
//    self.newsScroll.showsVerticalScrollIndicator = NO;
//    self.newsScroll.showsHorizontalScrollIndicator = NO;
//    self.newsScroll.pagingEnabled = YES;
//    self.newsScroll.bounces = NO;
//    [self.backScroll addSubview:self.newsScroll];
//    for (int i = 0; i < 5; i++) {
//        [self.newsScroll addSubview:[self createImageAndTitleWithFrame:CGRectMake(110*i, 0, 100, 100) title:@"哈哈哈" image:nil tag:2999+i]];
//    }
//
    return self.backScroll;
}
/** 监听输入 */
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.searchTF.text isEqualToString:@"搜索喜欢的场馆"]) {
        self.searchTF.text = @"";
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.searchTF.text.length < 1) {
        self.searchTF.text = @"搜索喜欢的场馆";
    }
}
/** 创建滚动图 */
- (void)setScrollView{
    for (int i = 0; i < self.topListArr.count; i++) {
        NSDictionary *dic = self.topListArr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 20)*i, 0, KGScreenWidth - 20, 120)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[dic[@"cover"] componentsSeparatedByString:@"#"] firstObject]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.tag = 300 + i;
        [self.topScroll addSubview:imageView];
        
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImageView:)];
        [imageView addGestureRecognizer:tag];
    }
}
/** 点击事件 */
- (void)selectImageView:(UITapGestureRecognizer *)tag{
    NSDictionary *dic = self.topListArr[tag.view.tag - 300];
    if ([dic[@"type"] integerValue] == 2 && [dic[@"type"] integerValue] == 7 && [dic[@"type"] integerValue] == 12) {
        
    }else if ([dic[@"type"] integerValue] == 5){
        KGInstitutionDramaDetailVC *vc = [[KGInstitutionDramaDetailVC alloc]initWithNibName:@"KGInstitutionDramaDetailVC" bundle:nil];
        vc.sendID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        [self pushHideenTabbarViewController:vc animted:YES];
    }else{
        KGAgencyDetailVC *vc = [[KGAgencyDetailVC alloc]init];
        vc.sendID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        [self pushHideenTabbarViewController:vc animted:YES];
    }
}
/** 滚动视图代理 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.topScroll) {
        self.pageCol.currentPage = scrollView.contentOffset.x/(KGScreenWidth - 20);
    }
}
/** 点击按钮 */
- (UIView *)createWtihFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag{
    UIView *btuView = [[UIView alloc]initWithFrame:frame];
    UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 11, frame.size.width, 11)];
    tmpLab.text = title;
    tmpLab.textAlignment = NSTextAlignmentCenter;
    tmpLab.textColor = KGBlackColor;
    tmpLab.font = KGFontSHRegular(11);
    [btuView addSubview:tmpLab];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 20, 20)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btuView addSubview:imageView];
    
    UIButton *btu = [UIButton buttonWithType:UIButtonTypeCustom];
    btu.frame = btuView.bounds;
    btu.tag = tag;
    [btu addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [btuView addSubview:btu];
    
    return btuView;
}
/** 点击事件 */
- (void)selectAction:(UIButton *)sender{
    if (sender.tag == 999) {
        /** 美术 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleArts;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1000){
        /** 设计 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleDesign;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1001){
        /** 摄影 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStylePhotography;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1002){
        /** 戏剧 */
        KGInstitutionDramaVC *vc = [[KGInstitutionDramaVC alloc]init];
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1003){
        /** 电影 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleMovies;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1004){
        /** 音乐 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleMusic;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1005){
        /** 美食 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleFood;
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (sender.tag == 1006){
        /** 剧院 */
        KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
        vc.scenarioStyle = KGScenarioStyleTheatre;
        [self pushHideenTabbarViewController:vc animted:YES];
    }
}
/** 图片文字 */
- (UIView *)createImageAndTitleWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)imageUrl tag:(NSInteger)tag{
    UIView *btuView = [[UIView alloc]initWithFrame:frame];
    UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 26, frame.size.width, 11)];
    tmpLab.text = title;
    tmpLab.textAlignment = NSTextAlignmentCenter;
    tmpLab.textColor = KGWhiteColor;
    tmpLab.font = KGFontSHRegular(11);
    [btuView addSubview:tmpLab];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:btuView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = KGLineColor;
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    [btuView addSubview:imageView];
    
    UIButton *btu = [UIButton buttonWithType:UIButtonTypeCustom];
    btu.frame = btuView.bounds;
    btu.tag = tag;
    [btu addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [btuView addSubview:btu];
    
    return btuView;
}
/** 列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setUI];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.listView];
    [self.listView registerNib:[UINib nibWithNibName:@"KGAgencyHomePageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyHomePageCell"];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lowListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGAgencyHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyHomePageCell" forIndexPath:indexPath];
    if (self.lowListArr.count > 0) {
        NSDictionary *dic = self.lowListArr[indexPath.row];
        [cell cellDetailWithDictionary:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.lowListArr[indexPath.row];
    if ([dic[@"type"] integerValue] == 7 || [dic[@"type"] integerValue] == 2 || [dic[@"type"] integerValue] == 12 || [dic[@"type"] integerValue] == 8 || [dic[@"type"] integerValue] == 9 || [dic[@"type"] integerValue] == 10 || [dic[@"type"] integerValue] == 11) {
        KGInstitutionMoviesDetailVC *vc = [[KGInstitutionMoviesDetailVC alloc]init];
        vc.sendID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if ([dic[@"type"] integerValue] == 5){
        KGInstitutionDramaDetailVC *vc = [[KGInstitutionDramaDetailVC alloc]initWithNibName:@"KGInstitutionDramaDetailVC" bundle:nil];
        vc.sendID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        [self pushHideenTabbarViewController:vc animted:YES];
    }else{
        KGAgencyDetailVC *vc = [[KGAgencyDetailVC alloc]init];
        vc.sendID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        [self pushHideenTabbarViewController:vc animted:YES];
    }
}
/** 点击搜索 */
- (void)searchHoistryData{
    self.searchView.hidden = NO;
}
- (KGInstitutionSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[KGInstitutionSearchView alloc] shareInstanceWithType:@"场所"];
        __weak typeof(self) weakSelf = self;
        _searchView.sendSearchResult = ^(NSString * _Nonnull result) {
            [weakSelf pushControllerWithSearchResult:result];
        };
        [self.navigationController.view addSubview:_searchView];
    }
    return _searchView;
}
/** 跳转页面加载 */
- (void)pushControllerWithSearchResult:(NSString *)result{
    KGAgencyHomePageVC *vc = [[KGAgencyHomePageVC alloc]init];
    vc.scenarioStyle = KGScenarioStyleArts;
    vc.searchResultStr = result;
    [self pushHideenTabbarViewController:vc animted:YES];
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
