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
    
    [self setUpListView];
    [self setUpLowView];
    [self setUpMoreView];
    
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
// MARK: --创建机构列表--
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
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
        return 10;
    }else{
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
//        return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:KGScreenWidth tableView:self.listView];
        return 220;
    }else{
        return 120;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row%2==0) {
            KGNewsDetailUILabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsDetailUILabCell"];
            return cell;
        }else{
            KGNewsDetailUIImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGNewsDetailUIImageViewCell"];
            return cell;
        }
    }else{
        KGAgencyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyDetailTableViewCell"];
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
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan (2)"]]) {
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }else{
        [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    }
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
    NSLog(@"12131312");
}
/** 举报按钮点击事件 */
- (void)reportAction{
    self.moreView.hidden = YES;
    NSLog(@"adsadasdsadasdas");
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
        releaseBtu.frame  =CGRectMake(KGScreenWidth - 50, 75, 35, 20);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
