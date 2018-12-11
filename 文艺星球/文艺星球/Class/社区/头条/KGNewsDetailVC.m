//
//  KGNewsDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGNewsDetailVC.h"
#import "KGNewsDetailUIImageViewCell.h"
#import "KGNewsDetailUILabCell.h"
#import "KGAgencyDetailTableViewCell.h"
#import "KGLrregularView.h"
#import "KGNewsWebVC.h"
#import "KGDatingReportVC.h"

@interface KGNewsDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UITextViewDelegate>
/** 图书列表 */
@property (nonatomic,strong) UITableView *listView;
/** 点赞按钮 */
@property (nonatomic,strong) UIButton *zansBtu;
/** 顶部更多 */
@property (nonatomic,strong) KGLrregularView *moreView;
/** 评论view */
@property (nonatomic,strong) UIView *commentView;
/** 想法 */
@property (nonatomic,strong) UITextView *ideaView;
/** 字数统计 */
@property (nonatomic,strong) UILabel *countLab;
@property (nonatomic,strong) NSDictionary *detailDic;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;
/** 顶部组件 */
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *socureLab;
@property (nonatomic,strong) UILabel *timeLab;
/** 低部组件 */
@property (nonatomic,strong) YYLabel *socureNameLab;
@property (nonatomic,strong) UILabel *detailLab;
@property (nonatomic,strong) UILabel *commentLab;

@property (nonatomic,copy) NSArray *contentArr;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KGNewsDetailVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.moreView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectMake(15, 0, 50, 30) title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    [self setRightNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"more"] font:nil color:nil select:@selector(rightNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    
    self.pageIndex = 1;
    self.dataArr = [NSMutableArray array];
    
    [self requestData];
    [self requestCommentData];
    [self setUpListView];
    [self setUpLowView];
    [self setUpMoreView];
    
}
/** 新闻详情页 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectNewsByNid parameters:@{@"value":self.sendID} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            weakSelf.detailDic = result[@"data"];
            weakSelf.contentArr = weakSelf.detailDic[@"newsContentList"];
            [weakSelf changeUIDetail];
        }
        [weakSelf.listView reloadData];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 评论列表 */
- (void)requestCommentData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectNewsCommentListByNid parameters:@{@"nid":self.sendID,@"pageIndex":@(self.pageIndex),@"pageSize":@"20"} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView reloadData];
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [weakSelf.listView reloadData];
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.moreView.hidden == NO) {
        self.moreView.hidden = YES;
    }else{
        self.moreView.hidden = NO;
    }
}
/** 新闻头 */
- (UIView *)setUpHeaderView{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 100)];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, KGScreenWidth, 15)];
    self.titleLab.textColor = KGBlackColor;
    self.titleLab.font = KGFontSHBold(15);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.numberOfLines = 0;
    [self.headerView addSubview:self.titleLab];
    
    self.socureLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, KGScreenWidth, 15)];
    self.socureLab.textColor = KGGrayColor;
    self.socureLab.font = KGFontSHRegular(12);
    self.socureLab.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.socureLab];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, KGScreenWidth, 15)];
    self.timeLab.textColor = KGGrayColor;
    self.timeLab.font = KGFontSHRegular(12);
    self.timeLab.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.timeLab];
    
    return self.headerView;
}
/** 新闻尾 */
- (UIView *)setUpFooterView{
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 100)];
    self.socureNameLab = [[YYLabel alloc]initWithFrame:CGRectMake(15, 0, KGScreenWidth - 30, 15)];
    self.socureNameLab.textColor = KGGrayColor;
    self.socureNameLab.font = KGFontSHRegular(12);
    self.socureNameLab.textAlignment = NSTextAlignmentCenter;
    self.socureNameLab.numberOfLines = 0;
    [self.footerView addSubview:self.socureNameLab];
    /** 设置富文本 */
    NSString *string = [NSString stringWithFormat:@"来源：%@    点击跳转原文",self.detailDic[@"newsSource"]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    attributedString.alignment = NSTextAlignmentLeft;
    attributedString.font = KGFontSHRegular(12);
    attributedString.color = KGBlackColor;
    [attributedString setColor:KGBlueColor range:[string rangeOfString:@"跳转原文"]];
    __weak typeof(self) weakSelf = self;
    /** 点击用户协议 */
    [attributedString setTextHighlightRange:[string rangeOfString:@"跳转原文"] color:KGBlueColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        dispatch_async(dispatch_get_main_queue(), ^{
            KGNewsWebVC *vc = [[KGNewsWebVC alloc]init];
            vc.webUrl = weakSelf.detailDic[@"newsDetailUrl"];
            [weakSelf pushHideenTabbarViewController:vc animted:YES];
        });
    }];
    self.socureNameLab.attributedText = attributedString;
    
    self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, KGScreenWidth - 30, 15)];
    self.detailLab.textColor = KGGrayColor;
    self.detailLab.font = KGFontSHRegular(12);
    self.detailLab.textAlignment = NSTextAlignmentCenter;
    self.detailLab.numberOfLines = 0;
    self.detailLab.text = @"文章与图片均来源于网络，言论与观点不代表本站意愿，如有任何意见和疑义等，请联系本站。";
    [self.footerView addSubview:self.detailLab];
    
    self.commentLab = [[UILabel alloc]initWithFrame:CGRectMake(15,self.footerView.frame.size.height - 15, KGScreenWidth - 30, 15)];
    self.commentLab.textColor = KGBlackColor;
    self.commentLab.font = KGFontSHRegular(14);
    self.commentLab.text = @"评论列表";
    [self.footerView addSubview:self.commentLab];
    
    return self.footerView;
}
// MARK: --创建机构列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 50)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setUpHeaderView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    __weak typeof(self) weakSelf = self;
    self.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        weakSelf.dataArr = [NSMutableArray array];
        [weakSelf requestCommentData];
        [weakSelf.listView.mj_header beginRefreshing];
    }];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex++;
        [weakSelf requestCommentData];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:self.listView];
    
    [self.listView registerClass:[KGNewsDetailUILabCell class] forCellReuseIdentifier:@"KGNewsDetailUILabCell"];
    [self.listView registerClass:[KGNewsDetailUIImageViewCell class] forCellReuseIdentifier:@"KGNewsDetailUIImageViewCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGAgencyDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyDetailTableViewCell"];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
/** 代理方法以及数据源 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.contentArr.count;
    }else{
        return self.dataArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.contentArr.count > 0) {
            NSDictionary *dic = self.contentArr[indexPath.row];
            if (dic[@"img"]) {
                NSString *lastObjStr = [[dic[@"img"] componentsSeparatedByString:@"#"] lastObject];
                NSArray *tmp = [lastObjStr componentsSeparatedByString:@"|"];
                if (tmp.count > 0) {
                    NSInteger widthStr = [[[lastObjStr componentsSeparatedByString:@"|"] lastObject] integerValue];
                    NSInteger heightStr = [[[lastObjStr componentsSeparatedByString:@"|"] firstObject] integerValue];
                    return (KGScreenWidth - 30)/widthStr*heightStr + 30;
                }else{
                    return 400;
                }
            }else{
                NSString *str = dic[@"content"];
                return [str boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(14)} context:nil].size.height + 30;
            }
        }
        return 220;
    }else{
        return 120;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        return [self setUpFooterView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 100;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.contentArr.count > 0) {
            NSDictionary *dic = self.contentArr[indexPath.row];
            if (dic[@"img"]) {
                KGNewsDetailUIImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsDetailUIImageViewCell"];
                [cell cellDetailWithImage:dic[@"img"]];
                return cell;
            }else{
                KGNewsDetailUILabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsDetailUILabCell"];
                [cell cellDetailWithString:dic[@"content"]];
                return cell;
            }
        }else{
            KGNewsDetailUILabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsDetailUILabCell"];
            return cell;
        }
    }else{
        KGAgencyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyDetailTableViewCell"];
        if (self.dataArr.count > 0) {
            NSDictionary *dic = self.dataArr[indexPath.row];
            cell.typeStr = @"新闻";
            [cell cellDetailWithDictionary:dic];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/** 底部评论框 */
- (void)setUpLowView{
    UIView *lowView = [[UIView alloc]initWithFrame:CGRectMake(0,KGScreenHeight - 50, KGScreenWidth, 50)];
    lowView.backgroundColor = KGWhiteColor;
    [self.view insertSubview:lowView atIndex:99];
    /** 写个评论 */
    UIButton *writeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    writeBtu.frame = CGRectMake(15, 10, 170, 30);
    [writeBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [writeBtu setTitle:@"写个评论..." forState:UIControlStateNormal];
    writeBtu.titleLabel.font = KGFontSHRegular(12);
    writeBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    writeBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    writeBtu.layer.borderColor = KGLineColor.CGColor;
    writeBtu.layer.borderWidth = 1;
    writeBtu.layer.cornerRadius = 5;
    writeBtu.layer.masksToBounds = YES;
    [writeBtu addTarget:self action:@selector(writeAction) forControlEvents:UIControlEventTouchUpInside];
    [lowView addSubview:writeBtu];
    /** 点赞按钮 */
    self.zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zansBtu.frame = CGRectMake(KGScreenWidth - 135, 10, 30, 30);
    [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    [self.zansBtu addTarget:self action:@selector(zansAction:) forControlEvents:UIControlEventTouchUpInside];
    [lowView addSubview:self.zansBtu];
    /** 评论 */
    UIButton *commentBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtu.frame = CGRectMake(KGScreenWidth - 90, 10, 30, 30);
    [commentBtu setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    [commentBtu addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [lowView addSubview:commentBtu];
    /** 分享 */
    UIButton *shareBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtu.frame = CGRectMake(KGScreenWidth - 45, 10, 30, 30);
    [shareBtu setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [shareBtu addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [lowView addSubview:shareBtu];
}
/** 写个评论 */
- (void)writeAction{
    self.commentView.hidden = NO;
}
/** 点赞点击事件 */
- (void)zansAction:(UIButton *)sender{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [KGRequest postWithUrl:AddNewsLikeStatusByUid parameters:@{@"nid":self.sendID,@"cnType":@"0"} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            [[KGHUD showMessage:@"操作成功"] hideAnimated:YES afterDelay:1];
            if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan (2)"]]) {
                [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
            }else{
                [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
            }
        }else{
            [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
    }];
}
/** 评论 */
- (void)commentAction{
    self.commentView.hidden = NO;
}
/** 分享 */
- (void)shareAction{
    
}
/** 顶部更多view */
- (void)setUpMoreView{
    self.moreView = [[KGLrregularView alloc]initWithFrame:CGRectMake(KGScreenWidth - 125, KGRectNavAndStatusHight, 120, 100)];
    self.moreView.hidden = YES;
    [self.navigationController.view addSubview:self.moreView];
    /** 收藏按钮 */
    UIButton *collectionBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    collectionBtu.frame  =CGRectMake(0, 10, 120, 45);
    [collectionBtu setTitle:@"收藏" forState:UIControlStateNormal];
    [collectionBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [collectionBtu setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    collectionBtu.titleLabel.font = KGFontSHRegular(14);
    collectionBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    collectionBtu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    collectionBtu.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [collectionBtu addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.moreView addSubview:collectionBtu];
    /** 分割线 */
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(50, 55, 70, 1)];
    line.backgroundColor = KGLineColor;
    [self.moreView addSubview:line];
    /** 举报按钮 */
    UIButton *reportBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    reportBtu.frame  =CGRectMake(0, 55, 120, 45);
    [reportBtu setTitle:@"举报" forState:UIControlStateNormal];
    [reportBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    [reportBtu setImage:[UIImage imageNamed:@"jubao"] forState:UIControlStateNormal];
    reportBtu.titleLabel.font = KGFontSHRegular(14);
    reportBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    reportBtu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    reportBtu.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [reportBtu addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
    [self.moreView addSubview:reportBtu];
}
/** 收藏按钮点击事件 */
- (void)collectionAction{
    self.moreView.hidden = YES;
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [KGRequest postWithUrl:AddPersonCollect parameters:@{@"newsId":self.sendID,@"collectType":@"3",@"newsTitle":self.detailDic[@"newsTitle"],@"newsSource":self.detailDic[@"newsSource"],@"newsType":@"0"} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            [[KGHUD showMessage:@"收藏成功"] hideAnimated:YES afterDelay:1];
        }else{
            [[KGHUD showMessage:@"收藏失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [[KGHUD showMessage:@"访问失败"] hideAnimated:YES afterDelay:1];
    }];
}
/** 举报按钮点击事件 */
- (void)reportAction{
    self.moreView.hidden = YES;
    KGDatingReportVC *vc = [[KGDatingReportVC alloc]init];
    vc.sendID = self.sendID;
    vc.typeStr = @"新闻";
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 评论view */
- (UIView *)commentView{
    if (!_commentView) {
        _commentView = [[UIView alloc]initWithFrame:CGRectMake(0,0, KGScreenWidth, KGScreenHeight)];
        _commentView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.2];
        [self.view insertSubview:_commentView atIndex:99];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,KGScreenHeight - 100, KGScreenWidth, 100)];
        backView.backgroundColor = KGWhiteColor;
        [_commentView addSubview:backView];
        /** 输入框 */
        self.ideaView = [[UITextView alloc]initWithFrame:CGRectMake(15, 10 , KGScreenWidth - 30, 60)];
        self.ideaView.text = @"在这里写下你想说的...";
        self.ideaView.font = KGFontSHRegular(14);
        self.ideaView.textColor = KGGrayColor;
        self.ideaView.delegate = self;
        [backView addSubview:self.ideaView];
        /** 发布 */
        UIButton *releaseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        releaseBtu.frame  =CGRectMake(KGScreenWidth - 65, 50, 50, 30);
        [releaseBtu setTitle:@"发布" forState:UIControlStateNormal];
        [releaseBtu setTitleColor:KGWhiteColor forState:UIControlStateNormal];
        releaseBtu.titleLabel.font = KGFontSHRegular(11);
        releaseBtu.backgroundColor = KGBlueColor;
        releaseBtu.layer.cornerRadius = 5;
        releaseBtu.layer.masksToBounds = YES;
        [releaseBtu addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:releaseBtu];
        /** 字数统计 */
        self.countLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 100, 20)];
        self.countLab.textColor = KGGrayColor;
        self.countLab.text = @"0/100";
        self.countLab.font = KGFontSHRegular(14);
        [backView addSubview:self.countLab];
    }
    return _commentView;
}
/** 发布 */
- (void)releaseAction{
    if (self.ideaView.text.length > 0) {
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        __weak typeof(self) weakSelf = self;
        [KGRequest postWithUrl:AddNewsCommentByNid parameters:@{@"nid":self.sendID,@"comment":self.ideaView.text} succ:^(id  _Nonnull result) {
            [hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"评论成功"] hideAnimated:YES afterDelay:1];
                weakSelf.pageIndex = 1;
                weakSelf.dataArr = [NSMutableArray array];
                [weakSelf requestCommentData];
                
            }else{
                [[KGHUD showMessage:@"评论失败"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [hud hideAnimated:YES];
            [[KGHUD showMessage:@"请求失败"] hideAnimated:YES afterDelay:1];
        }];
        self.commentView.hidden = YES;
    }
}
/** 监听输入 */
- (void)textViewDidChange:(UITextView *)textView{
    self.countLab.text = [NSString stringWithFormat:@"%lu/100",(unsigned long)textView.text.length];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length < 1) {
        self.ideaView.text = @"在这里写下你想说的...";
        self.ideaView.textColor = KGGrayColor;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"在这里写下你想说的..."]) {
        self.ideaView.text = @"";
        self.ideaView.textColor = KGBlackColor;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if (touch.view == self.commentView) {
        self.commentView.hidden = YES;
    }
}
/** 修改UI */
- (void)changeUIDetail{
    self.titleLab.text = self.detailDic[@"newsTitle"];
    self.titleLab.frame = CGRectMake(0, 20, KGScreenWidth, [self.detailDic[@"newsTitle"] boundingRectWithSize:CGSizeMake(KGScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHBold(15)} context:nil].size.height);
    self.socureLab.text = [NSString stringWithFormat:@"%@  %@ 著",self.detailDic[@"newsSource"],self.detailDic[@"newsAuthor"]];
    self.timeLab.text = self.detailDic[@"newsTime"];
    self.socureLab.frame = CGRectMake(0, self.titleLab.frame.origin.y+self.titleLab.frame.size.height + 20, KGScreenWidth, 15);
    self.timeLab.frame = CGRectMake(0, self.socureLab.frame.origin.y+self.socureLab.frame.size.height + 15, KGScreenWidth, 15);
    self.headerView.frame = CGRectMake(0, 0, KGScreenWidth, self.timeLab.frame.origin.y+self.timeLab.frame.size.height + 20);
    
    [self.listView reloadData];
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
