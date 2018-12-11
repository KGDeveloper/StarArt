//
//  KGSquareDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSquareDetailVC.h"
#import "KGSquareDetailCell.h"
#import "KGReleaseTF.h"

typedef NS_ENUM(NSInteger,DATASTYLE) {
    DATASTYLE_LeftAliment = 0,
    DATASTYLE_CenterAliment,
    DATASTYLE_RightTopAliment,
    DATASTYLE_RightCenterAliment,
    DATASTYLE_RoundAliment,
};

@interface KGSquareDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 头像 */
@property (nonatomic,strong) UIImageView *headerImage;
/** 昵称 */
@property (nonatomic,strong) UILabel *nameLab;
/** 发布时间 */
@property (nonatomic,strong) UILabel *timeLab;
/** 文本view */
@property (nonatomic,strong) UIView *contextView;
/** 图片view */
@property (nonatomic,strong) UIScrollView *photosView;
/** 底部常规组件 */
@property (nonatomic,strong) UIView *bottomView;
/** 位置 */
@property (nonatomic,strong) UIButton *locationBtu;
/** 点赞 */
@property (nonatomic,strong) UIButton *zansBtu;
/** 收藏 */
@property (nonatomic,strong) UIImageView *contellionImage;
/** 评论 */
@property (nonatomic,strong) UIButton *commentBtu;
/** 头视图 */
@property (nonatomic,strong) UIView *backView;
/** 样式 */
@property (nonatomic,assign) DATASTYLE style;
/** 详情 */
@property (nonatomic,strong) UITableView *listView;
/** 写评论或者回复 */
@property (nonatomic,strong) KGReleaseTF *wirteCommentView;
/** 评论 */
@property (nonatomic,strong) NSMutableArray *commentArr;
@property (nonatomic,strong) NSDictionary *userDic;

@end

@implementation KGSquareDetailVC

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
    /** 定制右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"关注" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"动态详情";
    self.view.backgroundColor = KGWhiteColor;
    self.commentArr = [NSMutableArray array];
    [self requestData];
    [self setUpListView];
    [self setCommentVIew];

}
/** 请求数据 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:[ReleaseFriendsGetMessageDetail stringByAppendingString:[NSString stringWithFormat:@"/%@",self.newsId]] parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            if ([dic[@"composing"] integerValue] == 0) {
                weakSelf.style = DATASTYLE_LeftAliment;
            }else if ([dic[@"composing"] integerValue] == 1){
                weakSelf.style = DATASTYLE_CenterAliment;
            }else if ([dic[@"composing"] integerValue] == 2){
                weakSelf.style = DATASTYLE_RoundAliment;
            }else if ([dic[@"composing"] integerValue] == 3){
                weakSelf.style = DATASTYLE_RightTopAliment;
            }else if ([dic[@"composing"] integerValue] == 4){
                weakSelf.style = DATASTYLE_RightCenterAliment;
            }
            [weakSelf setContentStr:dic[@"content"]];
            [weakSelf setPhotosArr:dic[@"imgs"]];
            [weakSelf.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"userPortraitUri"]]];
            weakSelf.nameLab.text = dic[@"userName"];
            weakSelf.timeLab.text = dic[@"createTimeStr"];
            if ([dic[@"isOwn"] integerValue] == 1) {
                weakSelf.rightNavItem.hidden = YES;
            }else{
                weakSelf.rightNavItem.hidden = NO;
                if ([dic[@"isAttention"] integerValue] == 1) {
                    [weakSelf.rightNavItem setTitle:@"已关注" forState:UIControlStateNormal];
                }else{
                    [weakSelf.rightNavItem setTitle:@"关注" forState:UIControlStateNormal];
                }
            }
            if ([dic[@"isLike"] integerValue] == 0) {
                [weakSelf.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
            }else{
                [weakSelf.zansBtu setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
            }
            [weakSelf.commentBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"rccommentNum"]] forState:UIControlStateNormal];
            [weakSelf.zansBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"likeCount"]] forState:UIControlStateNormal];
            [weakSelf.locationBtu setTitle:dic[@"location"] forState:UIControlStateNormal];
            NSArray *commentTmpArr = dic[@"comments"];
            if (commentTmpArr.count > 0) {
                [weakSelf.commentArr addObjectsFromArray:commentTmpArr];
            }
            weakSelf.userDic = dic;
            [weakSelf.listView reloadData];
            [hud hideAnimated:YES];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if ([self.rightNavItem.currentTitle isEqualToString:@"关注"]) {
        [self.rightNavItem setTitle:@"已关注" forState:UIControlStateNormal];
        [self.rightNavItem setTitleColor:KGGrayColor forState:UIControlStateNormal];
    }else{
        [self.rightNavItem setTitle:@"关注" forState:UIControlStateNormal];
        [self.rightNavItem setTitleColor:KGBlueColor forState:UIControlStateNormal];
    }
}
/** 头部用户信息 */
- (void)setHeaderView{
    /** 用户头像 */
    self.headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
    self.headerImage.backgroundColor = KGLineColor;
    self.headerImage.layer.cornerRadius = 15;
    self.headerImage.layer.masksToBounds = YES;
    [self.backView addSubview:self.headerImage];
    /** 用户昵称 */
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, KGScreenWidth - 70, 13)];
    self.nameLab.text = @"轩哥哥";
    self.nameLab.textColor = KGBlueColor;
    self.nameLab.font = KGFontSHRegular(13);
    [self.backView addSubview:self.nameLab];
    /** 发布时间 */
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(55, 31, KGScreenWidth - 70, 9)];
    self.timeLab.text = @"3分钟前";
    self.timeLab.textColor = KGGrayColor;
    self.timeLab.font = KGFontSHRegular(9);
    [self.backView addSubview:self.timeLab];
}
/** 横向排版 */
- (UIView *)headerHorizontalView:(CGFloat)height{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, height)];
    self.contextView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, KGScreenWidth, height - (KGScreenWidth - 30)/69*46 - 190)];
    [self.backView addSubview:self.contextView];
    
    self.photosView = [[UIScrollView alloc]initWithFrame:CGRectMake(15,height - (KGScreenWidth - 30)/69*46 - 130 , KGScreenWidth - 30, (KGScreenWidth - 30)/69*46)];
    self.photosView.pagingEnabled = YES;
    self.photosView.showsVerticalScrollIndicator = NO;
    self.photosView.showsHorizontalScrollIndicator = NO;
    [self.backView addSubview:self.photosView];
    [self setUpBottomView:CGRectMake(0, height - 95, KGScreenWidth, 95)];
    return self.backView;
}
/** 纵向排版 */
- (UIView *)headerVerticalView:(CGFloat)height{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, height)];
    self.contextView = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth - 110, 60, 110, (KGScreenWidth - 140)/5*7)];
    [self.backView addSubview:self.contextView];
    
    self.photosView = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 60, KGScreenWidth - 140, (KGScreenWidth - 140)/5*7)];
    self.photosView.pagingEnabled = YES;
    self.photosView.showsVerticalScrollIndicator = NO;
    self.photosView.showsHorizontalScrollIndicator = NO;
    [self.backView addSubview:self.photosView];
    [self setUpBottomView:CGRectMake(0, height - 95, KGScreenWidth, 95)];
    return self.backView;
}
/** 圆图排版 */
- (UIView *)headerRoundView:(CGFloat)height{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, height)];
    self.contextView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, KGScreenWidth, height - 420)];
    [self.backView addSubview:self.contextView];
    
    self.photosView = [[UIScrollView alloc]initWithFrame:CGRectMake((KGScreenWidth - 230)/2, height - 360, 230, 230)];
    self.photosView.pagingEnabled = YES;
    self.photosView.showsVerticalScrollIndicator = NO;
    self.photosView.showsHorizontalScrollIndicator = NO;
    [self.backView addSubview:self.photosView];
    [self setUpBottomView:CGRectMake(0, height - 95, KGScreenWidth, 95)];
    return self.backView;
}
/** 创建文本显示 */
- (void)setContentStr:(NSString *)contentStr{
    NSArray *endArr = [contentStr componentsSeparatedByString:@"@"];
    [self setLabelWithArr:endArr];
}
/** 创建label */
- (void)setLabelWithArr:(NSArray *)arr{
    if (arr.count > 0) {
        switch (self.style) {
            case DATASTYLE_LeftAliment:/** 横向排版居左 */
                self.listView.tableHeaderView = [self headerHorizontalView:(KGScreenWidth - 30)/69*46 + arr.count*23 + 190];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(15,23*i, KGScreenWidth - 30, 13)];
                    tmp.text = arr[i];
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    [self.contextView addSubview:tmp];
                }
                self.contextView.frame = CGRectMake(0, 60, KGScreenWidth, 23*arr.count);
                [self setLabAligment:NSTextAlignmentLeft];
                break;
            case DATASTYLE_CenterAliment:/** 横向排版居中 */
                self.listView.tableHeaderView = [self headerHorizontalView:(KGScreenWidth - 30)/69*46+arr.count*23 + 190];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(15,23*i, KGScreenWidth - 30, 13)];
                    tmp.text = arr[i];
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    [self.contextView addSubview:tmp];
                }
                self.contextView.frame = CGRectMake(0, 60, KGScreenWidth, 23*arr.count);
                [self setLabAligment:NSTextAlignmentCenter];
                break;
            case DATASTYLE_RightTopAliment:/** 竖向排版居上 */
                self.listView.tableHeaderView = [self headerVerticalView:(KGScreenWidth - 160)/5*7 + 190];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(self.contextView.bounds.size.width - 28 - 23*i,0, 13, [arr[i] boundingRectWithSize:CGSizeMake(13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontFZ(13)} context:nil].size.height)];
                    tmp.text = arr[i];
                    tmp.numberOfLines = 0;
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    tmp.textAlignment = NSTextAlignmentLeft;
                    [self.contextView addSubview:tmp];
                }
                break;
            
            case DATASTYLE_RightCenterAliment:/** 竖向排版居中 */
                self.listView.tableHeaderView = [self headerVerticalView:(KGScreenWidth - 160)/5*7 + 190];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(self.contextView.bounds.size.width - 28 - 23*i,0, 13,[arr[i] boundingRectWithSize:CGSizeMake(13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontFZ(13)} context:nil].size.height)];
                    tmp.center = CGPointMake(self.contextView.bounds.size.width - 28 - 23*i + 7, self.contextView.bounds.origin.y + self.contextView.bounds.size.height/2);
                    tmp.text = arr[i];
                    tmp.numberOfLines = 0;
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    tmp.textAlignment = NSTextAlignmentRight;
                    [self.contextView addSubview:tmp];
                }
                break;
            case DATASTYLE_RoundAliment:/** 横向排版居中 */
                self.listView.tableHeaderView = [self headerRoundView:230+arr.count*23 + 190];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(15,23*i, KGScreenWidth - 30, 13)];
                    tmp.text = arr[i];
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    [self.contextView addSubview:tmp];
                }
                self.contextView.frame = CGRectMake(0, 60, KGScreenWidth, 23*arr.count);
                [self setLabAligment:NSTextAlignmentCenter];
                break;
                
            default:
                break;
        }
    }
    [self setHeaderView];
    [self.listView reloadData];
}
/** 创建Imageview */
- (void)setPhotosArr:(NSArray *)photosArr{
    if (photosArr.count > 0) {
        switch (self.style) {
            case DATASTYLE_RoundAliment:
                self.photosView.contentSize = CGSizeMake(230*photosArr.count, 230);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(230*i, 0, 230, 230)];
                    NSDictionary *dic = photosArr[i];
                    [image sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 115;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
            case DATASTYLE_LeftAliment:
                self.photosView.contentSize = CGSizeMake((KGScreenWidth - 30)*photosArr.count, (KGScreenWidth - 30)/69*46);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 30)*i, 0, KGScreenWidth - 30, (KGScreenWidth - 30)/69*46)];
                    NSDictionary *dic = photosArr[i];
                    [image sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 5;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
            case DATASTYLE_CenterAliment:
                self.photosView.contentSize = CGSizeMake((KGScreenWidth - 30)*photosArr.count, (KGScreenWidth - 30)/69*46);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 30)*i, 0, KGScreenWidth - 30, (KGScreenWidth - 30)/69*46)];
                    NSDictionary *dic = photosArr[i];
                    [image sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 5;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
            case DATASTYLE_RightTopAliment:
                self.photosView.contentSize = CGSizeMake((KGScreenWidth - 140)*photosArr.count, (KGScreenWidth - 140)/5*7);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 140)*i, 0, (KGScreenWidth - 140), (KGScreenWidth - 140)/5*7)];
                    NSDictionary *dic = photosArr[i];
                    [image sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 5;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
            case DATASTYLE_RightCenterAliment:
                self.photosView.contentSize = CGSizeMake((KGScreenWidth - 140)*photosArr.count, (KGScreenWidth - 140)/5*7);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 140)*i, 0, (KGScreenWidth - 140), (KGScreenWidth - 140)/5*7)];
                    NSDictionary *dic = photosArr[i];
                    [image sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 5;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
                
            default:
                break;
        }
    }
    [self.listView reloadData];
}
/** 文本对其 */
- (void)setLabAligment:(NSTextAlignment)labAligment{
    for (id obj in self.contextView.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *tmp = obj;
            tmp.textAlignment = labAligment;
        }
    }
}
/** 底部组件 */
- (void)setUpBottomView:(CGRect)frmae{
    self.bottomView = [[UIView alloc]initWithFrame:frmae];
    [self.backView addSubview:self.bottomView];
    
    self.locationBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationBtu.frame = CGRectMake(15, 0, KGScreenWidth - 30, 15);
    [self.locationBtu setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [self.locationBtu setTitle:@"北京798艺术区" forState:UIControlStateNormal];
    [self.locationBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.locationBtu.titleLabel.font = KGFontSHRegular(11);
    self.locationBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.locationBtu.userInteractionEnabled = NO;
    self.locationBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.bottomView addSubview:self.locationBtu];
    
    self.contellionImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 11, 14)];
    self.contellionImage.image = [UIImage imageNamed:@"shoucang (2)"];
    self.contellionImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.bottomView addSubview:self.contellionImage];
    
    /** 评论 */
    self.commentBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtu.frame = CGRectMake(KGScreenWidth - 90, 30, 75, 20);
    [self.commentBtu setTitle:@"232" forState:UIControlStateNormal];
    [self.commentBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.commentBtu setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    self.commentBtu.titleLabel.font = KGFontSHRegular(13);
    self.commentBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.commentBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.commentBtu addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.commentBtu];
    /** 点赞 */
    self.zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zansBtu.frame = CGRectMake(KGScreenWidth - 165, 30, 75, 20);
    [self.zansBtu setTitle:@"232" forState:UIControlStateNormal];
    [self.zansBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    self.zansBtu.titleLabel.font = KGFontSHRegular(13);
    self.zansBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.zansBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.zansBtu addTarget:self action:@selector(zansAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.zansBtu];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 60, KGScreenWidth, 20)];
    line.backgroundColor = KGLineColor;
    [self.bottomView addSubview:line];
    
    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, KGScreenWidth - 30, 20)];
    tmp.text = @"所有评论";
    tmp.textColor = KGGrayColor;
    tmp.font = KGFontSHRegular(10);
    [self.bottomView addSubview:tmp];
}
/** 评论 */
- (void)commentAction:(UIButton *)sender{
    [self.wirteCommentView becomeFirstResponder];
}
/** 评论 */
- (void)zansAction:(UIButton *)sender{
    NSArray *tmp = self.userDic[@"imgs"];
    NSDictionary *tmpDic = [tmp firstObject];
    [KGRequest postWithUrl:[addLike stringByAppendingString:[NSString stringWithFormat:@"/%@",self.userDic[@"id"]]] parameters:@{@"portraitUri":[KGUserInfo shareInstance].userPortrait,@"rfmImg":tmpDic[@"imageUrl"],@"comName":[KGUserInfo shareInstance].userName} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan (2)"]]) {
                [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
            }else{
                [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
            }
            [[KGHUD showMessage:@"操作成功"] hideAnimated:YES afterDelay:1];
        }else{
            [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [[KGHUD showMessage:@"操作失败"] hideAnimated:YES afterDelay:1];
    }];
}
/** 详情列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGSquareDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGSquareDetailCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGSquareDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareDetailCell"];
    if (self.commentArr.count > 0) {
        NSDictionary *dic = self.commentArr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"comPortraitUri"]]];
        cell.nameLab.text = dic[@"comName"];
        cell.timeLab.text = dic[@"createTimeFormat"];
        cell.contextLab.text = dic[@"content"];
    }
    return cell;
}
/** 写评论或者回复 */
- (void)setCommentVIew{
    self.wirteCommentView = [[KGReleaseTF alloc]initWithFrame:CGRectMake(0, KGScreenHeight - 50, KGScreenWidth, 50)];
    self.wirteCommentView.placeholder = @"写个评论吧";
    self.wirteCommentView.textColor = KGBlackColor;
    self.wirteCommentView.font = KGFontSHRegular(12);
    self.wirteCommentView.leftView = [UIView new];
    self.wirteCommentView.backgroundColor = KGWhiteColor;
    UIButton *releaseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtu.frame = CGRectMake(0, 0, 50, 25);
    [releaseBtu setTitle:@"发布" forState:UIControlStateNormal];
    [releaseBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    releaseBtu.titleLabel.font = KGFontSHRegular(10);
    [releaseBtu addTarget:self action:@selector(releaseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.wirteCommentView.rightView = releaseBtu;
    self.wirteCommentView.rightViewMode = UITextFieldViewModeAlways;
    [self.view insertSubview:self.wirteCommentView atIndex:99];
}
/** 发布按钮 */
- (void)releaseAction:(UIButton *)sender{
    if (self.wirteCommentView.text.length > 0 && ![self.wirteCommentView.text isEqualToString:@"写个评论吧"]) {
        NSArray *tmp = self.userDic[@"imgs"];
        NSDictionary *tmpDic = [tmp firstObject];
        __weak typeof(self) weakSelf = self;
        [KGRequest postWithUrl:AddComment parameters:@{@"content":self.wirteCommentView.text,@"rfmId":self.userDic[@"id"],@"rfmImg":tmpDic[@"imageUrl"],@"comName":[KGUserInfo shareInstance].userName,@"byComUid":[NSString stringWithFormat:@"%@",self.userDic[@"uid"]],@"comPortraitUri":[KGUserInfo shareInstance].userPortrait} succ:^(id  _Nonnull result) {
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"评论成功"] hideAnimated:YES afterDelay:1];
            }else{
                [[KGHUD showMessage:@"评论失败"] hideAnimated:YES afterDelay:1];
            }
            weakSelf.commentArr = [NSMutableArray array];
            [weakSelf requestData];
        } fail:^(NSError * _Nonnull error) {
            [[KGHUD showMessage:@"评论失败"] hideAnimated:YES afterDelay:1];
        }];
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
