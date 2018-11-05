//
//  KGHometownVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/30.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGHometownVC.h"
#import "KGHomeTownTF.h"
#import "KGHomeTownListViewCell.h"

typedef NS_ENUM(NSInteger,ChooseType) {
    ChooseTypeCountry = 0,
    ChooseTypeProivences,
    ChooseTypeCity,
};

@interface KGHometownVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AMapSearchDelegate>
/** 选择家乡 */
@property (nonatomic,strong) UITableView *listView;
/** 家乡 */
@property (nonatomic,strong) KGHomeTownTF *homeTownTF;
/** 选择家乡 */
@property (nonatomic,strong) UILabel *homeTownLab;
/** 国家名称 */
@property (nonatomic,strong) NSMutableArray *countryArr;
/** 显示数据 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** 获取行政区规划 */
@property (nonatomic,strong) AMapSearchAPI *search;
/** 当前选择级别 */
@property (nonatomic,assign) ChooseType chooseType;
/** 是否显示选择 */
@property (nonatomic,copy) NSString *chooseName;
/** 默认显示字段 */
@property (nonatomic,copy) NSString *defoultStr;
/** 省份 */
@property (nonatomic,copy) NSString *proviencesStr;

@end

@implementation KGHometownVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"我的家乡";
    self.view.backgroundColor = KGWhiteColor;
    
    self.defoultStr = @"中国";
    [self setCountryCode];
    [self setHomeTownView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.sendHomeTownToController) {
        self.sendHomeTownToController(self.homeTownLab.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建家乡选择列表 */
- (void)setHomeTownView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 50)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self settableViewHeader];
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGHomeTownListViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGHomeTownListViewCell"];
}
/** 设置头视图 */
- (UIView *)settableViewHeader{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 50)];
    backView.backgroundColor = KGLineColor;
    /** 搜索框 */
    self.homeTownTF = [[KGHomeTownTF alloc]initWithFrame:CGRectMake(15, 10, KGScreenWidth - 30,30)];
    self.homeTownTF.placeholder = @"搜索家乡城市";
    self.homeTownTF.backgroundColor = KGWhiteColor;
    self.homeTownTF.font = KGFontSHRegular(12);
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 30)];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.image = [UIImage imageNamed:@"sousuohuise"];
    self.homeTownTF.leftView = image;
    self.homeTownTF.leftViewMode = UITextFieldViewModeAlways;
    self.homeTownTF.layer.cornerRadius = 5;
    self.homeTownTF.layer.masksToBounds = YES;
    self.homeTownTF.delegate = self;
    [backView addSubview:self.homeTownTF];
    
    return backView;
}
/** 设置列表头视图 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 60)];
    back.backgroundColor = KGWhiteColor;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 10, 50)];
    imageView.image = [UIImage imageNamed:@"jiaxiangdingwei"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [back addSubview:imageView];
    
    self.homeTownLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, KGScreenWidth - 40, 50)];
    if (self.proviencesStr.length > 0) {
        if (self.chooseName.length > 0) {
            self.homeTownLab.text = [NSString stringWithFormat:@"%@-%@-%@",self.defoultStr,self.proviencesStr,self.chooseName];
        }else{
            self.homeTownLab.text = [NSString stringWithFormat:@"%@-%@",self.defoultStr,self.proviencesStr];
        }
    }else{
        self.homeTownLab.text = self.defoultStr;
    }
    self.homeTownLab.textColor = KGBlackColor;
    self.homeTownLab.font = KGFontSHRegular(14);
    [back addSubview:self.homeTownLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KGScreenWidth, 10)];
    line.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    [back addSubview:line];
    
    return back;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGHomeTownListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGHomeTownListViewCell"];
    if (self.dataArr.count > 0) {
        cell.titleLab.text = self.dataArr[indexPath.row];
        if ([self.dataArr[indexPath.row] isEqualToString:@"中国"]) {
            cell.nextImage.hidden = NO;
            cell.chooseLab.hidden = NO;
        }else if (self.chooseType == ChooseTypeCity){
            cell.nextImage.hidden = YES;
            cell.chooseLab.hidden = YES;
            if ([self.chooseName isEqualToString:self.dataArr[indexPath.row]]) {
                cell.chooseLab.hidden = NO;
            }
        }else if (self.chooseType == ChooseTypeProivences){
            cell.nextImage.hidden = NO;
            cell.chooseLab.hidden = YES;
        }else{
            cell.nextImage.hidden = YES;
            cell.chooseLab.hidden = YES;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KGHomeTownListViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.nextImage.hidden == NO) {
        if (self.chooseType == ChooseTypeCountry) {
            self.defoultStr = cell.titleLab.text;
            [self searchCountryProvincesNameWithCountryName:@"中国"];
            [KGHUD showMessage:@"正在加载..." toView:self.view];
        }else if (self.chooseType == ChooseTypeProivences){
            [self searchCountryProvincesNameWithCountryName:cell.titleLab.text];
            [KGHUD showMessage:@"正在加载..." toView:self.view];
            self.proviencesStr = cell.titleLab.text;
        }
        if (self.chooseType == ChooseTypeCountry) {
            self.chooseType = ChooseTypeProivences;
        }else if (self.chooseType == ChooseTypeProivences){
            self.chooseType = ChooseTypeCity;
        }
    }else{
        if (self.chooseType == ChooseTypeCity){
            self.chooseName = cell.titleLab.text;
            [self.listView reloadData];
        }else{
            self.defoultStr = cell.titleLab.text;
            [self.listView reloadData];
        }
    }
}
/** 监测键盘 */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
/** 获取国家名称 */
- (void)setCountryCode{
    self.countryArr = [NSMutableArray array];
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    for (NSString *countryCode in countryArray) {
        NSString *countryName = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [self.countryArr addObject:countryName];
    }
    [self.countryArr removeObject:@"中国"];
    [self.countryArr setObject:@"中国" atIndexedSubscript:0];
    self.dataArr = [NSMutableArray arrayWithArray:self.countryArr.copy];
}
/** 获取国家下级单位 */
- (void)searchCountryProvincesNameWithCountryName:(NSString *)countryName{
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;
    AMapDistrictSearchRequest *dist = [[AMapDistrictSearchRequest alloc]init];
    dist.keywords = countryName;
    dist.requireExtension = NO;
    [self.search AMapDistrictSearch:dist];
}
/** 获取回调数据 */
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response{
    if (response == nil) {
        return;
    }
    NSArray *provinces = [response.districts firstObject].districts;
    NSMutableArray *provincesArr = [NSMutableArray array];
    for (AMapDistrict *dis in provinces) {
        [provincesArr addObject:dis.name];
    }
    self.dataArr = [NSMutableArray arrayWithArray:provincesArr.copy];
    [self.listView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
/** 获取失败回调 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    if (error) {
        [[KGHUD showMessage:@"获取数据失败" toView:self.view] hideAnimated:YES afterDelay:1];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
