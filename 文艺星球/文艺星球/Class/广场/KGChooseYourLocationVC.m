//
//  KGChooseYourLocationVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGChooseYourLocationVC.h"
#import "KGLocationCell.h"

@interface KGChooseYourLocationVC ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 选择位置 */
@property (nonatomic,strong) UITableView *listView;
/** 地理建筑 */
@property (nonatomic,strong) NSMutableArray *locationArr;
/** 定位管理 */
@property (nonatomic,strong) AMapLocationManager *manager;
/** 获取POI数据 */
@property (nonatomic,strong) AMapSearchAPI *search;
/** 显示提示 */
@property (nonatomic,strong) MBProgressHUD *hud;
/** 选择 */
@property (nonatomic,assign) NSInteger chooseIndex;
/** 当前选择地址 */
@property (nonatomic,copy) NSString *chooseName;

@end

@implementation KGChooseYourLocationVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHRegular(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGGrayColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"位置";
    self.view.backgroundColor = KGWhiteColor;
    self.rightNavItem.userInteractionEnabled = NO;
    
    self.locationArr = [NSMutableArray array];
    [self locationView];
    [self mapApi];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.sendLocation) {
        self.sendLocation(self.chooseName);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** 显示位置 */
- (void)locationView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    [self.listView registerNib:[UINib nibWithNibName:@"KGLocationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGLocationCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.locationArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGLocationCell"];
    if (self.locationArr.count > 0) {
        if (indexPath.row == self.chooseIndex) {
            cell.chooseStyle.hidden = NO;
        }else{
            cell.chooseStyle.hidden = YES;
        }
        NSDictionary *dic = self.locationArr[indexPath.row];
        cell.titleLab.text = dic[@"name"];
        cell.detailLab.text = dic[@"address"];
    }
    return cell;
}
/** 请求地理围栏 */
- (void)mapApi{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.manager = [[AMapLocationManager alloc]init];
    [self.manager setDesiredAccuracy:kCLLocationAccuracyBest];
    self.manager.locationTimeout = 10;
    self.manager.reGeocodeTimeout = 10;
    __weak typeof(self) weakSelf = self;
    [self.manager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            [[KGHUD showMessage:@"定位出错，请刷新"] hideAnimated:YES afterDelay:1];
            return;
        }
        [weakSelf requestPOIDataWithCLLocationCoordinate2D:location.coordinate];
    }];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.chooseIndex = indexPath.row;
    [self.listView reloadData];
    NSDictionary *dic = self.locationArr[indexPath.row];
    self.chooseName = dic[@"name"];
    self.rightNavItem.userInteractionEnabled = YES;
    [self.rightNavItem setTitleColor:KGBlueColor forState:UIControlStateNormal];
}
/** 获取POI数据 */
- (void)requestPOIDataWithCLLocationCoordinate2D:(CLLocationCoordinate2D)coordinate{
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc]init];
    request.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    request.sortrule = 0;
    request.requireExtension = YES;
    [self.search AMapPOIAroundSearch:request];
}
/** POI搜索回调 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count == 0) {
        [self.hud hideAnimated:YES];
        [self.listView reloadData];
        return;
    }
    
    NSArray *poiArr = response.pois;
    for (AMapPOI *poi in poiArr) {
        [self.locationArr addObject:@{@"name":poi.name,@"address":poi.address}];
    }
    [self.hud hideAnimated:YES];
    [self.listView reloadData];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"404"];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"可能因为网络原因加载失败，请点击刷新";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    // 设置按钮标题
    NSString *buttonTitle = @"重新加载";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],NSForegroundColorAttributeName:KGBlueColor
                                 };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self mapApi];
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
