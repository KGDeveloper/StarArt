//
//  KGAgencyDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/9.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyDetailVC.h"
#import "KGAgencyDetailTableViewCell.h"
#import "KGAgencyDetailListViewCell.h"
#import "KGAgencyExhibitionDetailVC.h"

@interface KGAgencyDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *listView;
/** 顶部滚动图 */
@property (nonatomic,strong) UIScrollView *topScrollView;
/** 页码 */
@property (nonatomic,strong) UIPageControl *pageControl;
/** 地址 */
@property (nonatomic,strong) UILabel *addressLab;
/** 电话 */
@property (nonatomic,strong) UILabel *telPhoneLab;
/** 时间 */
@property (nonatomic,strong) UILabel *timeLab;
/** 左侧按钮 */
@property (nonatomic,strong) UIButton *leftBtu;
/** 右侧按钮 */
@property (nonatomic,strong) UIButton *rightBtu;
/** 信息 */
@property (nonatomic,strong) UILabel *detailLab;
/** 相关图片 */
@property (nonatomic,strong) UILabel *imageCountLab;
/** 全部评论 */
@property (nonatomic,strong) UILabel *commentCountLab;
/** 相关图片滚动 */
@property (nonatomic,strong) UIScrollView *aboutScrollView;
/** 展览 */
@property (nonatomic,strong) UITableView *rightListView;
@property (nonatomic,strong) NSDictionary *detailDic;

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
    
    [self requestData];
    [self setUpListView];
}
/** 请求详情 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectCommunityPlaceByID parameters:@{@"id":self.sendID} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            weakSelf.detailDic = result[@"data"];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
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
    /** 地址 */
    self.addressLab = [[UILabel alloc]initWithFrame:CGRectMake(45, KGScreenWidth/75*47 + 15, KGScreenWidth - 60, 15)];
    self.addressLab.text = @"北京市朝阳区酒仙桥路798艺术区";
    self.addressLab.textColor = [UIColor blackColor];
    self.addressLab.font = KGFontSHRegular(14);
    [topView addSubview:self.addressLab];
    /** 电话 */
    self.telPhoneLab = [[UILabel alloc]initWithFrame:CGRectMake(45, KGScreenWidth/75*47 + 45, KGScreenWidth - 60, 15)];
    self.telPhoneLab.text = @"010-87645765";
    self.telPhoneLab.textColor = [UIColor blackColor];
    self.telPhoneLab.font = KGFontSHRegular(14);
    [topView addSubview:self.telPhoneLab];
    /** 时间 */
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(45, KGScreenWidth/75*47 + 75, KGScreenWidth - 60, 15)];
    self.timeLab.text = @"周二到周六 10:00-18:00";
    self.timeLab.textColor = [UIColor blackColor];
    self.timeLab.font = KGFontSHRegular(14);
    [topView addSubview:self.timeLab];
    /** 直线 */
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/75*47 + 105, KGScreenWidth, 10)];
    line.backgroundColor = KGLineColor;
    [topView addSubview:line];
    /** 左侧按钮 */
    self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtu.frame = CGRectMake(0, KGScreenWidth/75*47 + 115, KGScreenWidth/2, 50);
    [self.leftBtu setTitle:@"机构信息" forState:UIControlStateNormal];
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.leftBtu.titleLabel.font = KGFontSHRegular(15);
    [self.leftBtu addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.leftBtu];
    /** 右侧按钮 */
    self.rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtu.frame = CGRectMake(KGScreenWidth/2, KGScreenWidth/75*47 + 115, KGScreenWidth/2, 50);
    [self.rightBtu setTitle:@"展览(3)" forState:UIControlStateNormal];
    [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.rightBtu.titleLabel.font = KGFontSHRegular(15);
    [self.rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.rightBtu];
    /** 直线 */
    UIView *lowline = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/75*47 + 154, KGScreenWidth, 1)];
    lowline.backgroundColor = KGLineColor;
    [topView addSubview:lowline];
    /** 机构信息 */
    NSMutableAttributedString *attributeString = [self setAttributeWithString:@"在iOS开发过程中，经常会用到给字体加下划线，显示不同颜色和大小的字体等需求，经常遇到这种需求都是直接到百度或者谷歌直接把代码粘过来，并没有做系统的整理，今天刚好有时间，把这部分的内容整理一下，便于后续的开发，闲话不说，接下来就跟着我一起来了解一下NSMutableAttributedString吧.NSAttributedString对象管理适用于字符串中单个字符或字符范围的字符串和关联的属性集（例如字体和字距）。NSAttributedString对象的默认字体是Helvetica 12点，可能与平台的默认系统字体不同。因此，您可能希望创建适用于您的应用程序的非默认属性的新字符串。您还可以使用NSParagraphStyle类及其子类NSMutableParagraphStyle来封装NSAttributedString类使用的段落或标尺属性。"];
    self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenWidth/75*47 + 170, KGScreenWidth - 30, [attributeString boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height)];
    self.detailLab.attributedText = attributeString;
    self.detailLab.numberOfLines = 0;
    self.detailLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.detailLab.textColor = KGBlackColor;
    self.detailLab.font = KGFontSHRegular(14);
    self.detailLab.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:self.detailLab];
    /** 右侧展览 */
    self.rightListView = [[UITableView alloc]initWithFrame:CGRectMake(0,KGScreenWidth/75*47 + 170, KGScreenWidth, 200)];
    self.rightListView.hidden = YES;
    self.rightListView.delegate = self;
    self.rightListView.dataSource = self;
    self.rightListView.tableFooterView = [UIView new];
    self.rightListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightListView.showsVerticalScrollIndicator = NO;
    self.rightListView.showsHorizontalScrollIndicator = NO;
    [topView addSubview:self.rightListView];
    [self.rightListView registerNib:[UINib nibWithNibName:@"KGAgencyDetailListViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyDetailListViewCell"];
    /** 直线 */
    UIView *labline = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/75*47 + 370, KGScreenWidth, 10)];
    labline.backgroundColor = KGLineColor;
    [topView addSubview:labline];
    /** 相关图片 */
    self.imageCountLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenWidth/75*47 + 380, KGScreenWidth - 30, 50)];
    self.imageCountLab.textColor = KGBlackColor;
    self.imageCountLab.text = @"相关图片（300）";
    self.imageCountLab.font = KGFontSHBold(15);
    [topView addSubview:self.imageCountLab];
    /** 图片 */
    self.aboutScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(15, KGScreenWidth/75*47 + 430, KGScreenWidth - 30, 75)];
    self.aboutScrollView.contentSize = CGSizeMake(90*5, 75);
    self.aboutScrollView.bounces = NO;
    self.aboutScrollView.pagingEnabled = YES;
    self.aboutScrollView.showsVerticalScrollIndicator = NO;
    self.aboutScrollView.showsHorizontalScrollIndicator = NO;
    [topView addSubview:self.aboutScrollView];
    /** 直线 */
    UIView *iamgeLine = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/75*47 + 525, KGScreenWidth, 10)];
    iamgeLine.backgroundColor = KGLineColor;
    [topView addSubview:iamgeLine];
    /** 全部评价 */
    self.commentCountLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenWidth/75*47 + 535, 120, 50)];
    self.commentCountLab.textColor = KGBlackColor;
    self.commentCountLab.text = @"全部评论（300）";
    self.commentCountLab.font = KGFontSHBold(15);
    [topView addSubview:self.commentCountLab];
    
    topView.frame = CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/75*47 + 585);
    return topView;
}
/** 设置富文本 */
- (NSMutableAttributedString *)setAttributeWithString:(NSString *)string{
    NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc]init];
    par.lineSpacing = 8;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSParagraphStyleAttributeName:par}];
    return attributeString;
}
/** 左侧按钮点击事件 */
- (void)leftAction:(UIButton *)sender{
    if ([sender.currentTitleColor isEqual:KGBlackColor]) {
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    self.rightListView.hidden = YES;
    self.detailLab.hidden = NO;
}
/** 右侧按钮点击事件 */
- (void)rightAction:(UIButton *)sender{
    if ([sender.currentTitleColor isEqual:KGBlackColor]) {
        [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
        [self.leftBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    }
    self.rightListView.hidden = NO;
    self.detailLab.hidden = YES;
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.listView) {
        return 120;
    }
    return 100;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.listView) {
        return 10;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.listView) {
        KGAgencyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyDetailTableViewCell" forIndexPath:indexPath];
        return cell;
    }else{
        KGAgencyDetailListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyDetailListViewCell"];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightListView) {
        [self pushHideenTabbarViewController:[[KGAgencyExhibitionDetailVC alloc]init] animted:YES];
    }
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
