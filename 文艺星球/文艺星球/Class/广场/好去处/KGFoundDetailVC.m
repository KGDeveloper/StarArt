//
//  KGFoundDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGFoundDetailVC.h"
#import "KGFoundDetailCell.h"
#import "KGCommentOfThePlaceVC.h"

@interface KGFoundDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
/** 详情 */
@property (nonatomic,strong) UITableView *listView;
/** 顶部滚动图 */
@property (nonatomic,strong) UIScrollView *scrollView;
/** 小点 */
@property (nonatomic,strong) UIPageControl *pageView;
/** 分类 */
@property (nonatomic,strong) UILabel *classLab;
/** 地址 */
@property (nonatomic,strong) UILabel *addressLab;
/** 电话 */
@property (nonatomic,strong) UILabel *phoneLab;
/** 时间 */
@property (nonatomic,strong) UILabel *timeLab;
/** 人均 */
@property (nonatomic,strong) UILabel *payLab;
/** 名称 */
@property (nonatomic,strong) UILabel *nameLab;
/** 简介 */
@property (nonatomic,strong) UILabel *introLab;
/** 评论数 */
@property (nonatomic,strong) UILabel *commentLab;
/** 头视图 */
@property (nonatomic,strong) UIView *header;
/** 评论 */
@property (nonatomic,strong) UIButton *commentBtu;
@property (nonatomic,strong) NSDictionary *detailDic;
/** 评论列表 */
@property (nonatomic,copy) NSArray *commentArr;

@end

@implementation KGFoundDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    
    self.view.backgroundColor = KGWhiteColor;
    
    [self requestDetail];
}
/** 请求详情 */
- (void)requestDetail{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:FindGoodPlaceById parameters:@{@"id":self.detailId} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            weakSelf.detailDic = result[@"data"];
        }
        [weakSelf setUI];
        [weakSelf setUpCommentView];
        [weakSelf.listView reloadData];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 详情 */
- (void)setUI{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self headerView];
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    
    [self.listView registerClass:[KGFoundDetailCell class] forCellReuseIdentifier:@"KGFoundDetailCell"];
}
- (UIView *)headerView{
    self.header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/764*479 + 145)];
    /** 滚动图 */
    UIImageView *coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/764*479)];
    coverImage.backgroundColor = KGBlueColor;
    [coverImage sd_setImageWithURL:[NSURL URLWithString:self.detailDic[@"image"]]];
    [self.header addSubview:coverImage];
    /** 小点 */
    self.pageView = [[UIPageControl alloc]initWithFrame:CGRectMake(0, coverImage.bounds.size.height - 22, KGScreenWidth, 7)];
    NSArray *imagesArr = self.detailDic[@"images"];
    self.pageView.numberOfPages = imagesArr.count;
    self.pageView.pageIndicatorTintColor = KGWhiteColor;
    self.pageView.currentPageIndicatorTintColor = KGBlueColor;
    [self.header addSubview:self.pageView];
    /** 标签 */
    self.classLab = [[UILabel alloc]initWithFrame:CGRectMake(KGScreenWidth - 150, coverImage.bounds.size.height - 27, 135, 12)];
    self.classLab.text = self.detailDic[@"typeName"];
    self.classLab.textColor = KGWhiteColor;
    self.classLab.font = KGFontSHRegular(12);
    self.classLab.textAlignment = NSTextAlignmentRight;
    [self.header addSubview:self.classLab];
    /** 图标 */
    NSArray *imageArr = @[[UIImage imageNamed:@"定位"],[UIImage imageNamed:@"电话"],[UIImage imageNamed:@"时间"],[UIImage imageNamed:@"人均"]];
    for (int i = 0; i < 4; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, coverImage.bounds.size.height + 15 + 30*i, 15, 15)];
        imageview.image = imageArr[i];
        [self.header addSubview:imageview];
    }
    /** 地址 */
    self.addressLab = [[UILabel alloc]initWithFrame:CGRectMake(45, coverImage.bounds.size.height + 15, KGScreenWidth - 60, 14)];
    self.addressLab.text = self.detailDic[@"location"];
    self.addressLab.textColor = KGBlackColor;
    self.addressLab.font = KGFontSHRegular(14);
    self.addressLab.textAlignment = NSTextAlignmentLeft;
    [self.header addSubview:self.addressLab];
    /** 电话 */
    self.phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(45, coverImage.bounds.size.height + 45, KGScreenWidth - 60, 14)];
    self.phoneLab.text = self.detailDic[@"tel"];
    self.phoneLab.textColor = KGBlackColor;
    self.phoneLab.font = KGFontSHRegular(14);
    self.phoneLab.textAlignment = NSTextAlignmentLeft;
    [self.header addSubview:self.phoneLab];
    /** 时间 */
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(45, coverImage.bounds.size.height + 75, KGScreenWidth - 60, 14)];
    self.timeLab.text = self.detailDic[@"businessHours"];
    self.timeLab.textColor = KGBlackColor;
    self.timeLab.font = KGFontSHRegular(14);
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    [self.header addSubview:self.timeLab];
    /** 人均 */
    self.payLab = [[UILabel alloc]initWithFrame:CGRectMake(45, coverImage.bounds.size.height + 105, KGScreenWidth - 60, 14)];
    self.payLab.text = [NSString stringWithFormat:@"人均消费：CNY%@/人",self.detailDic[@"consumption"]];
    self.payLab.textColor = KGBlackColor;
    self.payLab.font = KGFontSHRegular(14);
    self.payLab.textAlignment = NSTextAlignmentLeft;
    [self.header addSubview:self.payLab];
    /** 直线 */
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,coverImage.bounds.size.height + 135, KGScreenWidth, 10)];
    line.backgroundColor = KGLineColor;
    [self.header addSubview:line];
    /** 名称 */
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, coverImage.bounds.size.height + 165, KGScreenWidth - 30, 14)];
    self.nameLab.text = self.detailDic[@"placenameca"];
    self.nameLab.textColor = KGBlackColor;
    self.nameLab.font = KGFontSHBold(14);
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    [self.header addSubview:self.nameLab];
    /** 名称 */
    NSMutableAttributedString *attributeString = [self setAttributeWithString:self.detailDic[@"introduce"]];
    self.introLab = [[UILabel alloc]initWithFrame:CGRectMake(15, coverImage.bounds.size.height + 195, KGScreenWidth - 30, [attributeString boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height)];
    self.introLab.attributedText = attributeString;
    self.introLab.numberOfLines = 0;
    self.introLab.textColor = KGBlackColor;
    self.introLab.font = KGFontSHRegular(14);
    self.introLab.textAlignment = NSTextAlignmentLeft;
    [self.header addSubview:self.introLab];
    CGFloat height = coverImage.bounds.size.height + 195 + [attributeString boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 15;
    CGFloat width = (KGScreenWidth - 310)/2;
    for (int i = 0; i < imagesArr.count; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(width, height, 100, 100)];
        imageview.backgroundColor = KGBlueColor;
        [imageview sd_setImageWithURL:[NSURL URLWithString:imagesArr[i]]];
        [self.header addSubview:imageview];
        if ((i+1)%3==0) {
            width = (KGScreenWidth - 310)/2;
            height += 105;
        }else{
            width += 105;
        }
    }
    self.header.frame = CGRectMake(0, 0, KGScreenWidth, height + 40);
    
    /** 评论数 */
    self.commentLab = [[UILabel alloc]initWithFrame:CGRectMake(15, height + 20, KGScreenWidth - 30, 14)];
    if (![self.detailDic[@"goodPlaceComments"] isKindOfClass:[NSNull class]]) {
        self.commentArr = self.detailDic[@"goodPlaceComments"];
    }else{
        self.commentArr = @[];
    }
    self.commentLab.text = [NSString stringWithFormat:@"全部评论（%lu）",(unsigned long)self.commentArr.count];
    self.commentLab.textColor = KGBlackColor;
    self.commentLab.font = KGFontSHBold(15);
    self.commentLab.textAlignment = NSTextAlignmentLeft;
    [self.header addSubview:self.commentLab];
    
    return self.header;
}
/** 代理 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.commentArr[indexPath.row];
    KGFoundDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGFoundDetailCell"];
    return [cell returnCellHeightWithDic:dic];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGFoundDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGFoundDetailCell"];
    if (self.commentArr.count > 0) {
        NSDictionary *dic = self.commentArr[indexPath.row];
        [cell cellWithDic:dic];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/** 滚动视图代理 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger count = scrollView.contentOffset.x/KGScreenWidth;
    self.pageView.currentPage = count;
}
/** 设置富文本 */
- (NSMutableAttributedString *)setAttributeWithString:(NSString *)string{
    NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc]init];
    par.lineSpacing = 8;
    par.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSParagraphStyleAttributeName:par}];
    return attributeString;
}
/** 评论按钮 */
- (void)setUpCommentView{
    self.commentBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtu.frame = CGRectMake(KGScreenWidth - 55, KGScreenHeight - 140, 40, 40);
    [self.commentBtu setImage:[UIImage imageNamed:@"duihua"] forState:UIControlStateNormal];
    [self.commentBtu addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.commentBtu atIndex:99];
}
/** 点击事件 */
- (void)commentAction{
    if (self.detailId) {
        KGCommentOfThePlaceVC *commentVC = [[KGCommentOfThePlaceVC alloc]initWithNibName:@"KGCommentOfThePlaceVC" bundle:nil];
        commentVC.detailId = self.detailId;
        [self pushHideenTabbarViewController:commentVC animted:YES];
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
