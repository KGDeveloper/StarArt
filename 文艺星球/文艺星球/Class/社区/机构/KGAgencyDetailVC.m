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
#import "KGAgencyDetailAddCommentVC.h"

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
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;

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
    self.dataArr = [NSMutableArray array];
    self.page = 1;
    [self requestCommentData];
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
            weakSelf.listView.tableHeaderView = [weakSelf setUpTopScrollView];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 请求评论 */
- (void)requestCommentData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectCommunityPlaceCommentByMid parameters:@{@"id":self.sendID,@"pageIndex":@(self.page),@"pageSize":@"20"} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView reloadData];
        [weakSelf.rightListView reloadData];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView.mj_header endRefreshing];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [weakSelf.listView reloadData];
        [weakSelf.rightListView reloadData];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView.mj_header endRefreshing];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
// MARK: --创建机构列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    __weak typeof(self) weakSelf = self;
    self.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.dataArr = [NSMutableArray array];
        [weakSelf requestCommentData];
        [weakSelf.listView.mj_header beginRefreshing];
    }];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf requestCommentData];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:self.listView];
 
    [self.listView registerNib:[UINib nibWithNibName:@"KGAgencyDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyDetailTableViewCell"];
}
/** 头视图 */
- (UIView *)setUpTopScrollView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    /** 轮播图 */
    self.topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/750*700)];
    self.topScrollView.delegate = self;
    self.topScrollView.backgroundColor = KGLineColor;
    self.topScrollView.contentSize = CGSizeMake(KGScreenWidth, KGScreenWidth/750*700);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/750*700)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[[self.detailDic[@"image"] componentsSeparatedByString:@"#"]firstObject]]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    [self.topScrollView addSubview:imageView];
    self.topScrollView.bounces = NO;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    [topView addSubview:self.topScrollView];
    /** 页码 */
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(15, KGScreenWidth/750*700 - 22, KGScreenWidth, 7)];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = KGBlueColor;
    self.pageControl.pageIndicatorTintColor = KGWhiteColor;
    [topView addSubview:self.pageControl];
    /** 标签 */
    NSArray *imageArr = @[[UIImage imageNamed:@"定位"],[UIImage imageNamed:@"电话"],[UIImage imageNamed:@"时间"]];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, KGScreenWidth/750*700 + 15 + 30*i, 15, 15)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = imageArr[i];
        [topView addSubview:imageView];
    }
    /** 地址 */
    self.addressLab = [[UILabel alloc]initWithFrame:CGRectMake(45, KGScreenWidth/750*700 + 15, KGScreenWidth - 60, 15)];
    self.addressLab.text = self.detailDic[@"address"];
    self.addressLab.textColor = [UIColor blackColor];
    self.addressLab.font = KGFontSHRegular(14);
    [topView addSubview:self.addressLab];
    /** 电话 */
    self.telPhoneLab = [[UILabel alloc]initWithFrame:CGRectMake(45, KGScreenWidth/750*700 + 45, KGScreenWidth - 60, 15)];
    self.telPhoneLab.text = self.detailDic[@"telphone"];
    self.telPhoneLab.textColor = [UIColor blackColor];
    self.telPhoneLab.font = KGFontSHRegular(14);
    [topView addSubview:self.telPhoneLab];
    /** 时间 */
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(45, KGScreenWidth/750*700 + 75, KGScreenWidth - 60, 15)];
    self.timeLab.text = self.detailDic[@"potime"];
    self.timeLab.textColor = [UIColor blackColor];
    self.timeLab.font = KGFontSHRegular(14);
    [topView addSubview:self.timeLab];
    /** 直线 */
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/750*700 + 105, KGScreenWidth, 10)];
    line.backgroundColor = KGLineColor;
    [topView addSubview:line];
    /** 左侧按钮 */
    self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtu.frame = CGRectMake(0, KGScreenWidth/750*700 + 115, KGScreenWidth/2, 50);
    [self.leftBtu setTitle:@"机构信息" forState:UIControlStateNormal];
    [self.leftBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.leftBtu.titleLabel.font = KGFontSHRegular(15);
    [self.leftBtu addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.leftBtu];
    /** 右侧按钮 */
    self.rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtu.frame = CGRectMake(KGScreenWidth/2, KGScreenWidth/750*700 + 115, KGScreenWidth/2, 50);
    if (self.detailDic[@"relatedList"]) {
        NSArray *tmp = self.detailDic[@"relatedList"];
        if (tmp.count > 0) {
            [self.rightBtu setTitle:[NSString stringWithFormat:@"相关(%lu)",(unsigned long)tmp.count] forState:UIControlStateNormal];
        }else{
            [self.rightBtu setTitle:@"相关(暂无)" forState:UIControlStateNormal];
        }
    }else{
        [self.rightBtu setTitle:@"相关(暂无)" forState:UIControlStateNormal];
    }
    [self.rightBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.rightBtu.titleLabel.font = KGFontSHRegular(15);
    [self.rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.rightBtu];
    /** 直线 */
    UIView *lowline = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/750*700 + 154, KGScreenWidth, 1)];
    lowline.backgroundColor = KGLineColor;
    [topView addSubview:lowline];
    NSString *detailStr = nil;
    /** 机构信息 */
    if (![self.detailDic[@"blurb"] isKindOfClass:[NSNull class]]) {
        if (![self.detailDic[@"blurb"] isEqualToString:@""]) {
            detailStr = self.detailDic[@"blurb"];
        }else{
            detailStr = @"暂无";
        }
    }else{
        detailStr = @"暂无";
    }
    NSMutableAttributedString *attributeString = [self setAttributeWithString:detailStr];
    self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenWidth/750*700 + 170, KGScreenWidth - 30, [attributeString boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height)];
    self.detailLab.attributedText = attributeString;
    self.detailLab.numberOfLines = 0;
    self.detailLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.detailLab.textColor = KGBlackColor;
    self.detailLab.font = KGFontSHRegular(14);
    self.detailLab.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:self.detailLab];
    /** 右侧展览 */
    self.rightListView = [[UITableView alloc]initWithFrame:CGRectMake(0,KGScreenWidth/750*700 + 170, KGScreenWidth, 200)];
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
    UIView *labline = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/750*700 + 370, KGScreenWidth, 10)];
    labline.backgroundColor = KGLineColor;
    [topView addSubview:labline];
    /** 相关图片 */
    self.imageCountLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenWidth/750*700 + 380, KGScreenWidth - 30, 50)];
    self.imageCountLab.textColor = KGBlackColor;
    if (self.detailDic[@"mimages"]) {
        NSArray *tmp = self.detailDic[@"mimages"];
        if (tmp.count > 0) {
            self.imageCountLab.text = [NSString stringWithFormat:@"相关图片（%lu）",(unsigned long)tmp.count];
        }else{
            self.imageCountLab.text = @"相关图片（0）";
        }
    }else{
        self.imageCountLab.text = @"相关图片（0）";
    }
    self.imageCountLab.font = KGFontSHBold(15);
    [topView addSubview:self.imageCountLab];
    /** 图片 */
    self.aboutScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(15, KGScreenWidth/750*700 + 430, KGScreenWidth - 30, 75)];
    self.aboutScrollView.bounces = NO;
    self.aboutScrollView.pagingEnabled = YES;
    self.aboutScrollView.showsVerticalScrollIndicator = NO;
    self.aboutScrollView.showsHorizontalScrollIndicator = NO;
    [topView addSubview:self.aboutScrollView];
    [self setImageView];
    /** 直线 */
    UIView *iamgeLine = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenWidth/750*700 + 525, KGScreenWidth, 10)];
    iamgeLine.backgroundColor = KGLineColor;
    [topView addSubview:iamgeLine];
    /** 全部评价 */
    self.commentCountLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenWidth/750*700 + 535, 120, 50)];
    self.commentCountLab.textColor = KGBlackColor;
    self.commentCountLab.text = @"全部评论";
    self.commentCountLab.font = KGFontSHBold(15);
    [topView addSubview:self.commentCountLab];
    
    UIButton *scroeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    scroeBtu.frame = CGRectMake(KGScreenWidth - 95,KGScreenWidth/750*700 + 555,80, 20);
    [scroeBtu setTitle:@"我要评分" forState:UIControlStateNormal];
    scroeBtu.titleLabel.font = KGFontSHRegular(12);
    [scroeBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    scroeBtu.layer.cornerRadius = 10;
    scroeBtu.layer.borderWidth = 1;
    scroeBtu.layer.borderColor = KGBlackColor.CGColor;
    scroeBtu.layer.masksToBounds = YES;
    [scroeBtu addTarget:self action:@selector(addCommentAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:scroeBtu];
    
    topView.frame = CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/750*700 + 585);
    return topView;
}
/** 添加评论 */
- (void)addCommentAction{
    KGAgencyDetailAddCommentVC *vc = [[KGAgencyDetailAddCommentVC alloc]initWithNibName:@"KGAgencyDetailAddCommentVC" bundle:[NSBundle mainBundle]];
    vc.sendID = self.sendID;
    [self pushHideenTabbarViewController:vc animted:YES];
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
        return self.dataArr.count;
    }
    if (self.detailDic[@"relatedList"]) {
        NSArray *tmp = self.detailDic[@"relatedList"];
        if (tmp.count > 0) {
            return tmp.count;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.listView) {
        KGAgencyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyDetailTableViewCell" forIndexPath:indexPath];
        if (self.dataArr.count > 0) {
            NSDictionary *dic = self.dataArr[indexPath.row];
            [cell cellDetailWithDictionary:dic];
        }
        return cell;
    }else{
        KGAgencyDetailListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyDetailListViewCell"];
        if (self.detailDic[@"relatedList"]) {
            NSArray *tmp = self.detailDic[@"relatedList"];
            if (tmp.count > 0) {
                NSDictionary *dic = tmp[indexPath.row];
                [cell cellDetailWithDictionary:dic];
            }
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightListView) {
        if ([self.detailDic[@"type"] integerValue] == 1) {
            KGAgencyExhibitionDetailVC *vc = [[KGAgencyExhibitionDetailVC alloc]init];
            NSArray *tmp = self.detailDic[@"relatedList"];
            if (tmp.count > 0) {
                NSDictionary *dic = tmp[indexPath.row];
                vc.sendID = dic[@"id"];
            }
            [self pushHideenTabbarViewController:vc animted:YES];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.topScrollView) {
        self.pageControl.currentPage = scrollView.contentOffset.x/KGScreenWidth;
    }
}
/** 创建图片 */
- (void)setImageView{
    if (self.detailDic[@"mimages"]) {
        NSArray *tmp = self.detailDic[@"mimages"];
        if (tmp.count > 0) {
            self.aboutScrollView.contentSize = CGSizeMake(90*tmp.count, 75);
            for (int i = 0; i < tmp.count; i++) {
                NSDictionary *dic = tmp[i];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(90*i, 0, 75, 75)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[[dic[@"imageurl"] componentsSeparatedByString:@"#"]firstObject]]];
                [self.aboutScrollView addSubview:imageView];
            }
        }
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
