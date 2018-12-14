//
//  KGNearInstatutionVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/11.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGNearInstatutionVC.h"
#import "KGAgencyHomePageScreeningCell.h"
#import "KGInstitutionMoviesDetailVC.h"
#import "KGAgencyDetailVC.h"

@interface KGNearInstatutionVC ()<UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate>
/** 筛选条件 */
@property (nonatomic,strong) UIView *screenView;
/** 全城 */
@property (nonatomic,strong) UIButton *allCtiyBtu;
/** 类型 */
@property (nonatomic,strong) UIButton *typeClassBtu;
/** 确定 */
@property (nonatomic,strong) UIButton *shureBtu;
/** 顶部view */
@property (nonatomic,strong) UIView *topView;
/** 顶部滑动 */
@property (nonatomic,strong) UIView *line;
/** 左侧列表 */
@property (nonatomic,strong) UITableView *leftListView;
/** 右侧列表 */
@property (nonatomic,strong) UITableView *rightListView;
/** 单列列表 */
@property (nonatomic,strong) UITableView *onlyListView;
/** 第一个列表选中 */
@property (nonatomic,assign) NSInteger oneListCellRow;
/** 第二个列表选中 */
@property (nonatomic,assign) NSInteger twoListCellRow;
/** 第三个列表选中 */
@property (nonatomic,assign) NSInteger threeListCellRow;
/** 左侧列表标题 */
@property (nonatomic,copy) NSArray *oneArr;
/** 类型列表标题 */
@property (nonatomic,copy) NSArray *typeArr;
/** 城市二级列表 */
@property (nonatomic,strong) NSMutableArray *cityListArr;
/** 类型 */
@property (nonatomic,copy) NSString *typeStr;
/** 城市 */
@property (nonatomic,copy) NSString *cityStr;
/** 地区 */
@property (nonatomic,copy) NSString *areaStr;
/** 地图 */
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) MBProgressHUD *hud;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** 二级区域id */
@property (nonatomic,copy) NSString *sencedStr;
@property (nonatomic,copy) NSString *latStr;
@property (nonatomic,copy) NSString *longStr;
/** 类型ID */
@property (nonatomic,copy) NSString *classStr;

@end

@implementation KGNearInstatutionVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.hud hideAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KGWhiteColor;
    self.oneArr = @[@{@"city":@"北京",@"id":@"1"},@{@"city":@"上海",@"id":@"13"},@{@"city":@"广州",@"id":@"28"},@{@"city":@"深圳",@"id":@"36"},@{@"city":@"天津",@"id":@"43"},@{@"city":@"成都",@"id":@"65"},@{@"city":@"西安",@"id":@"54"}];
    self.typeArr = @[@{@"name":@"美术",@"id":@"1"},@{@"name":@"音乐",@"id":@"2"},@{@"name":@"书店",@"id":@"3"},@{@"name":@"设计",@"id":@"4"},@{@"name":@"戏剧",@"id":@"5"},@{@"name":@"摄影",@"id":@"6"},@{@"name":@"剧院",@"id":@"13"}];
    self.cityListArr = [NSMutableArray array];
    /** 初始赋值 */
    self.oneListCellRow = 0;
    self.twoListCellRow = 0;
    self.threeListCellRow = 0;
    self.longStr = @"";
    self.latStr = @"";
    self.sencedStr = @"";
    self.classStr = @"";
    self.dataArr = [NSMutableArray array];
    
    [self requestData];
    [self setUpMapView];
    
}
/** 请求数据 */
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    __block NSString *cityId = nil;
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
- (void)requestWithCity:(NSString *)cityId{
    __weak typeof(self) weakSelf = self;
    [[KGRequest shareInstance] requestYourLocation:^(CLLocationCoordinate2D location) {
        [weakSelf requestDataWithCity:cityId location:location];
    }];
}
- (void)requestDataWithCity:(NSString *)cityId location:(CLLocationCoordinate2D)location{
    __weak typeof(self) weakSelf = self;
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequest postWithUrl:FindAllMerchant parameters:@{@"longitude":@(location.longitude),@"latitude":@(location.latitude)} succ:^(id  _Nonnull result) {
        [weakSelf.hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
                [weakSelf mapViewAddOverLay];
            }
        }
    } fail:^(NSError * _Nonnull error) {
        [weakSelf.hud hideAnimated:YES];
    }];
}
/** 地图加点 */
- (void)mapViewAddOverLay{
    for (int i = 0; i < self.dataArr.count; i++) {
        NSDictionary *dic = self.dataArr[i];
        if (i == 0) {
            self.mapView.centerCoordinate = CLLocationCoordinate2DMake([dic[@"latitude"] doubleValue], [dic[@"longitude"] doubleValue]);
        }
        MAPointAnnotation *point = [[MAPointAnnotation alloc]init];
        point.coordinate = CLLocationCoordinate2DMake([dic[@"latitude"] doubleValue], [dic[@"longitude"] doubleValue]);
        point.title = [NSString stringWithFormat:@"%@\n%@,%@",dic[@"username"],dic[@"id"],dic[@"type"]];
        point.subtitle = dic[@"address"];
        [self.mapView addAnnotation:point];
    }
    [self.mapView reloadMap];
}
/** 添加地图 */
- (void)setUpMapView{
    self.mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    self.mapView.zoomLevel = 14;
    self.mapView.minZoomLevel = 5;
    self.mapView.maxZoomLevel = 19;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}
/** 添加到主窗体上 */
- (void)addScreenViewToSupView:(UIView *)fatherView topViewHeight:(CGFloat)topHeight{
    if (self.screenView.hidden == YES) {
        self.screenView.hidden = NO;
    }
    if (self.screenView.superview != fatherView) {
        [fatherView addSubview:self.screenView];
    }
    self.topView.frame = CGRectMake(0, 0, KGScreenWidth, topHeight);
    self.allCtiyBtu.frame = CGRectMake(KGScreenWidth/2 - 100,topHeight - 30, 70, 30);
    self.typeClassBtu.frame = CGRectMake(KGScreenWidth/2 + 30,topHeight - 30, 70, 30);
    self.shureBtu.frame = CGRectMake(KGScreenWidth - 55,topHeight - 30, 40, 30);
    self.line.frame = CGRectMake(self.allCtiyBtu.centerX - 15,topHeight - 2, 30, 2);
    self.leftListView.frame = CGRectMake(0, topHeight, KGScreenWidth/2, KGScreenHeight - topHeight);
    self.rightListView.frame = CGRectMake(KGScreenWidth/2, topHeight, KGScreenWidth/2, KGScreenHeight - topHeight);
    self.onlyListView.frame = CGRectMake(0, topHeight, KGScreenWidth, KGScreenHeight - topHeight);
    self.mapView.frame = CGRectMake(0, topHeight, KGScreenWidth, KGScreenHeight - topHeight - KGRectTabbarHeight);
    self.onlyListView.hidden = YES;
    self.leftListView.hidden = NO;
    self.rightListView.hidden = NO;
    [self requestCityProperidDataWithType:@"1"];
}
/** 筛选条件 */
- (UIView *)screenView{
    if (!_screenView) {
        _screenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
        _screenView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.2];
        [self.view insertSubview:_screenView atIndex:99];
        /** 顶部 */
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGRectNavAndStatusHight)];
        self.topView.backgroundColor = KGWhiteColor;
        [_screenView addSubview:self.topView];
        /** 全城 */
        self.allCtiyBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        self.allCtiyBtu.frame = CGRectMake(KGScreenWidth/2 - 70,KGRectNavAndStatusHight - 30, 70, 30);
        [self.allCtiyBtu setTitle:@"全城" forState:UIControlStateNormal];
        [self.allCtiyBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.allCtiyBtu.titleLabel.font = KGFontSHRegular(14);
        [self.allCtiyBtu addTarget:self action:@selector(allCityAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:self.allCtiyBtu];
        /** 类型 */
        self.typeClassBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        self.typeClassBtu.frame = CGRectMake(KGScreenWidth/2,KGRectNavAndStatusHight - 30, 70, 30);
        [self.typeClassBtu setTitle:@"类型" forState:UIControlStateNormal];
        [self.typeClassBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
        self.typeClassBtu.titleLabel.font = KGFontSHRegular(14);
        [self.typeClassBtu addTarget:self action:@selector(typeClassAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:self.typeClassBtu];
        /** 确定 */
        self.shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shureBtu.frame = CGRectMake(KGScreenWidth - 55,KGRectNavAndStatusHight - 30, 40, 30);
        [self.shureBtu setTitle:@"确定" forState:UIControlStateNormal];
        [self.shureBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
        self.shureBtu.titleLabel.font = KGFontSHRegular(13);
        self.shureBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.shureBtu addTarget:self action:@selector(shureAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:self.shureBtu];
        
        self.line = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth/2 - 50, 0, 30, 2)];
        self.line.backgroundColor = KGBlueColor;
        [self.topView addSubview:self.line];
        
    }
    return _screenView;
}
/** 全城点击事件 */
- (void)allCityAction:(UIButton *)sender{
    [self.allCtiyBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.typeClassBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    self.allCtiyBtu.titleLabel.font = KGFontSHRegular(14);
    self.typeClassBtu.titleLabel.font = KGFontSHRegular(13);
    [UIView animateWithDuration:0.1 animations:^{
        self.line.frame = CGRectMake(self.allCtiyBtu.centerX - 15,self.allCtiyBtu.frame.origin.y + 28, 30, 2);
    }];
    self.onlyListView.hidden = YES;
    self.leftListView.hidden = NO;
    self.rightListView.hidden = NO;
}
/** 类型点击事件 */
- (void)typeClassAction:(UIButton *)sender{
    [self.allCtiyBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.typeClassBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.allCtiyBtu.titleLabel.font = KGFontSHRegular(13);
    self.typeClassBtu.titleLabel.font = KGFontSHRegular(14);
    [UIView animateWithDuration:0.1 animations:^{
        self.line.frame = CGRectMake(self.typeClassBtu.centerX - 15,self.typeClassBtu.frame.origin.y + 28, 30, 2);
    }];
    self.onlyListView.hidden = NO;
    self.leftListView.hidden = YES;
    self.rightListView.hidden = YES;
}
/** 确定点击事件 */
- (void)shureAction:(UIButton *)sender{
    if ([self.sencedStr isEqualToString:@""]) {
        [[KGHUD showMessage:@"请选择筛选区域"] hideAnimated:YES afterDelay:1];
        return;
    }
    if ([self.classStr isEqualToString:@""]) {
        [[KGHUD showMessage:@"请选择筛选类型"] hideAnimated:YES afterDelay:1];
        return;
    }
    self.screenView.hidden = YES;
    self.dataArr = [NSMutableArray array];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView reloadMap];
    [self requestScreenData];
}
/** 左侧筛选左边栏 */
- (UITableView *)leftListView{
    if (!_leftListView) {
        _leftListView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth/2+2, 350)];
        _leftListView.delegate = self;
        _leftListView.dataSource = self;
        _leftListView.backgroundColor = [UIColor clearColor];
        _leftListView.showsVerticalScrollIndicator = NO;
        _leftListView.showsHorizontalScrollIndicator = NO;
        _leftListView.tableFooterView = [UIView new];
        _leftListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftListView.bounces = NO;
        [self.screenView addSubview:_leftListView];
        [_leftListView registerNib:[UINib nibWithNibName:@"KGAgencyHomePageScreeningCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyHomePageScreeningCell"];
    }
    return _leftListView;
}
/** 左侧筛选右边栏 */
- (UITableView *)rightListView{
    if (!_rightListView) {
        _rightListView = [[UITableView alloc]initWithFrame:CGRectMake(KGScreenWidth/2, 0, KGScreenWidth/2, 350)];
        _rightListView.delegate = self;
        _rightListView.dataSource = self;
        _rightListView.backgroundColor = [UIColor clearColor];
        _rightListView.showsVerticalScrollIndicator = NO;
        _rightListView.showsHorizontalScrollIndicator = NO;
        _rightListView.tableFooterView = [UIView new];
        _rightListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightListView.bounces = NO;
        [self.screenView addSubview:_rightListView];
        [_rightListView registerNib:[UINib nibWithNibName:@"KGAgencyHomePageScreeningCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyHomePageScreeningCell"];
    }
    return _rightListView;
}
/** 左侧筛选右边栏 */
- (UITableView *)onlyListView{
    if (!_onlyListView) {
        _onlyListView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 350)];
        _onlyListView.delegate = self;
        _onlyListView.dataSource = self;
        _onlyListView.backgroundColor = [UIColor clearColor];
        _onlyListView.showsVerticalScrollIndicator = NO;
        _onlyListView.showsHorizontalScrollIndicator = NO;
        _onlyListView.tableFooterView = [UIView new];
        _onlyListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _onlyListView.bounces = NO;
        [self.screenView addSubview:_onlyListView];
        [_onlyListView registerNib:[UINib nibWithNibName:@"KGAgencyHomePageScreeningCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyHomePageScreeningCell"];
    }
    return _onlyListView;
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftListView) {
        return self.oneArr.count;
    }else if (tableView == self.onlyListView){
        return self.typeArr.count;
    }else{
        return self.cityListArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftListView){
        KGAgencyHomePageScreeningCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyHomePageScreeningCell"];
        if (indexPath.row == self.oneListCellRow) {
            cell.backgroundColor = KGWhiteColor;
            cell.titleLab.textColor = KGBlackColor;
        }else{
            cell.backgroundColor = KGLineColor;
            cell.titleLab.textColor = KGGrayColor;
        }
        NSDictionary *dic = self.oneArr[indexPath.row];
        cell.titleLab.text = dic[@"city"];
        return cell;
    }else if (tableView == self.onlyListView){
        KGAgencyHomePageScreeningCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyHomePageScreeningCell"];
        if (indexPath.row == self.threeListCellRow) {
            cell.backgroundColor = KGWhiteColor;
            cell.titleLab.textColor = KGBlueColor;
        }else{
            cell.backgroundColor = KGWhiteColor;
            cell.titleLab.textColor = KGBlackColor;
        }
        NSDictionary *dic = self.typeArr[indexPath.row];
        cell.titleLab.text = dic[@"name"];
        return cell;
    }else{
        KGAgencyHomePageScreeningCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyHomePageScreeningCell"];
        if (indexPath.row == self.twoListCellRow) {
            cell.backgroundColor = KGWhiteColor;
            cell.titleLab.textColor = KGBlackColor;
        }else{
            cell.backgroundColor = KGWhiteColor;
            cell.titleLab.textColor = KGGrayColor;
        }
        if (self.cityListArr.count > 0) {
            NSDictionary *dic = self.cityListArr[indexPath.row];
            cell.titleLab.text = dic[@"cname"];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftListView){
        self.oneListCellRow = indexPath.row;
        [self.leftListView reloadData];
        NSDictionary *dic = self.oneArr[indexPath.row];
        self.cityListArr = [NSMutableArray array];
        [self requestCityProperidDataWithType:dic[@"id"]];
        self.sencedStr = @"";
    }else if (tableView == self.onlyListView){
        self.threeListCellRow = indexPath.row;
        [self.onlyListView reloadData];
        NSDictionary *dic = self.typeArr[indexPath.row];
        self.classStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
    }else{
        self.twoListCellRow = indexPath.row;
        [self.rightListView reloadData];
        NSDictionary *dic = self.cityListArr[indexPath.row];
        self.sencedStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
        self.latStr = [NSString stringWithFormat:@"%@",dic[@"latitude"]];
        self.longStr = [NSString stringWithFormat:@"%@",dic[@"longitude"]];
    }
}
/** 请求二级城市 */
- (void)requestCityProperidDataWithType:(NSString *)type{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.cityListArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:FindAllMerchantCity parameters:@{@"id":type} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.cityListArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.rightListView reloadData];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [weakSelf.rightListView reloadData];
    }];
}
/** 实现代理 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.draggable = NO;
        UIButton *selectBtu = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [selectBtu setTitle:[[annotation.title componentsSeparatedByString:@"\n"] lastObject] forState:UIControlStateNormal];
        [selectBtu addTarget:self action:@selector(selectPointAction:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = selectBtu;
        annotationView.pinColor = [self.dataArr indexOfObject:annotation]%3;
        return annotationView;
    }
    return nil;
}
/** 点击事件 */
- (void)selectPointAction:(UIButton *)sender{
    NSArray *tmpArr = [sender.currentTitle componentsSeparatedByString:@","];
    if ([[tmpArr lastObject] integerValue] == 1 || [[tmpArr lastObject] integerValue] == 3 || [[tmpArr lastObject] integerValue] == 4 || [[tmpArr lastObject] integerValue] == 5 || [[tmpArr lastObject] integerValue] == 6 || [[tmpArr lastObject] integerValue] == 13) {
        KGAgencyDetailVC *vc = [[KGAgencyDetailVC alloc]init];
        vc.sendID = [NSString stringWithFormat:@"%@",[tmpArr firstObject]];
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
    }else{
        KGInstitutionMoviesDetailVC *vc = [[KGInstitutionMoviesDetailVC alloc]init];
        vc.sendID = [NSString stringWithFormat:@"%@",[tmpArr firstObject]];
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
    }
}
/** 请求数据 */
- (void)requestScreenData{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:FindTypeAllMerchant parameters:@{@"longitude":@([self.longStr doubleValue]),@"latitude":@([self.latStr doubleValue]),@"id":self.sencedStr,@"type":self.classStr} succ:^(id  _Nonnull result) {
        [weakSelf.hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
                [weakSelf mapViewAddOverLay];
            }
        }
        [weakSelf.mapView reloadMap];
    } fail:^(NSError * _Nonnull error) {
        [weakSelf.hud hideAnimated:YES];
        [weakSelf.mapView reloadMap];
    }];
}
- (void)requestCityDataWithCityType:(NSString *)city{
    NSString *cityId = nil;
    CLLocationCoordinate2D location;
    if ([city isEqualToString:@"北京市"]) {
        location = CLLocationCoordinate2DMake(39.55, 116.24);
        cityId = @"1";
    }else if ([city isEqualToString:@"天津市"]){
        location = CLLocationCoordinate2DMake(39.02, 117.12);
        cityId = @"43";
    }else if ([city isEqualToString:@"西安市"]){
        location = CLLocationCoordinate2DMake(34.17, 108.57);
        cityId = @"54";
    }else if ([city isEqualToString:@"广州市"]){
        location = CLLocationCoordinate2DMake(23.08, 113.14);
        cityId = @"28";
    }else if ([city isEqualToString:@"成都市"]){
        location = CLLocationCoordinate2DMake(30.40, 104.04);
        cityId = @"65";
    }else if ([city isEqualToString:@"上海市"]){
        location = CLLocationCoordinate2DMake(31.24916171, 121.487899486);
        cityId = @"13";
    }else if ([city isEqualToString:@"深圳市"]){
        location = CLLocationCoordinate2DMake(22.5460535462, 114.025973657);
        cityId = @"36";
    }else{
        location = CLLocationCoordinate2DMake(39.55, 116.24);
        cityId = @"1";
    }
    __weak typeof(self) weakSelf = self;
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequest postWithUrl:FindAllMerchant parameters:@{@"longitude":@(location.longitude),@"latitude":@(location.latitude)} succ:^(id  _Nonnull result) {
        [weakSelf.hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
                [weakSelf mapViewAddOverLay];
            }
        }
    } fail:^(NSError * _Nonnull error) {
        [weakSelf.hud hideAnimated:YES];
    }];
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
