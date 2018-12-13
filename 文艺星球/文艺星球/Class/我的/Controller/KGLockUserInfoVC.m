//
//  KGLockUserInfoVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGLockUserInfoVC.h"
#import "KGSeeFriendsVC.h"
#import "KGChatVC.h"

@interface KGLockUserInfoVC ()<UIScrollViewDelegate>
/** 个人信息 */
@property (nonatomic,strong) UIScrollView *scrollView;
/** 顶部滚动图 */
@property (nonatomic,strong) UIScrollView *topScrollView;
/** 显示页数 */
@property (nonatomic,strong) UIPageControl *pageControl;
/** 左侧图片 */
@property (nonatomic,strong) UIImageView *leftImage;
/** 中间图片 */
@property (nonatomic,strong) UIImageView *centerImage;
/** 右侧图片 */
@property (nonatomic,strong) UIImageView *rightImage;
/** 行业 */
@property (nonatomic,strong) UILabel *industryLab;
/** 学校 */
@property (nonatomic,strong) UILabel *schoolLab;
/** 家乡 */
@property (nonatomic,strong) UILabel *hometownLab;

@end

@implementation KGLockUserInfoVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    
    [self requestUserInfo];
    [self setUI];
}
/** 查看个人资料 */
- (void)requestUserInfo{
    __weak typeof(self) weakSelf = self;
    __block MBProgressHUD *hud = [KGHUD showMessage:@"正在加载......" toView:self.view];
    [KGRequest postWithUrl:[RequestUserInfo stringByAppendingString:[NSString stringWithFormat:@"/%@",[KGUserInfo shareInstance].userId]] parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            [weakSelf changeUIWithDictionary:dic];
        }
        [hud hideAnimated:YES];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 导航栏返回按钮点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建ui */
- (void)setUI{
    /** 底部滚动图 */
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.scrollView];
    /** 个人信息滚动 */
    self.topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    self.topScrollView.contentSize = CGSizeMake(KGScreenWidth * 3, KGScreenHeight);
    self.topScrollView.bounces = NO;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.topScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.scrollView addSubview:self.topScrollView];
    /** 页数 */
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(KGScreenWidth - 50, KGScreenHeight - 15, 35, 8)];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = KGWhiteColor;
    self.pageControl.currentPageIndicatorTintColor = KGBlueColor;
    [self.scrollView addSubview:self.pageControl];
    /** 聊天 */
    UIButton *chatBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    chatBtu.frame = CGRectMake(KGScreenWidth/2 - 95, KGScreenHeight - 110, 50, 50);
    [chatBtu setImage:[UIImage imageNamed:@"dazhaohu"] forState:UIControlStateNormal];
    chatBtu.layer.cornerRadius = 25;
    chatBtu.layer.masksToBounds = YES;
    [chatBtu addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:chatBtu];
    /** 关注 */
    UIButton *focusBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    focusBtu.frame = CGRectMake(KGScreenWidth/2 + 45, KGScreenHeight - 110, 50, 50);
    [focusBtu setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
    focusBtu.layer.cornerRadius = 25;
    focusBtu.layer.masksToBounds = YES;
    [focusBtu addTarget:self action:@selector(focusAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:focusBtu];
    /** 动态 */
    UILabel *dynamicLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenHeight + 25, 100, 13)];
    dynamicLab.text = @"动态";
    dynamicLab.textColor = KGBlackColor;
    dynamicLab.font = KGFontSHBold(13);
    [self.scrollView addSubview:dynamicLab];
    /** 查看动态 */
    UIButton *seeDyBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    seeDyBtu.frame = CGRectMake(KGScreenWidth - 145, KGScreenHeight + 20, 130, 25);
    [seeDyBtu setImage:[UIImage imageNamed:@"dakai"] forState:UIControlStateNormal];
    seeDyBtu.imageView.contentMode = UIViewContentModeScaleAspectFit;
    seeDyBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [seeDyBtu addTarget:self action:@selector(seeDyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:seeDyBtu];
    /** 左侧图片 */
    self.leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(KGScreenWidth/2 - 50, KGScreenHeight + 60, 100, 100)];
    self.leftImage.backgroundColor = KGLineColor;
    self.leftImage.contentMode = UIViewContentModeScaleAspectFill;
    self.leftImage.layer.cornerRadius = 5;
    self.leftImage.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.leftImage];
    /** 中间图片 */
    self.centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, KGScreenHeight + 60, 100, 100)];
    self.centerImage.backgroundColor = KGLineColor;
    self.centerImage.contentMode = UIViewContentModeScaleAspectFill;
    self.centerImage.layer.cornerRadius = 5;
    self.centerImage.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.centerImage];
    /** 右侧图片 */
    self.rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(KGScreenWidth - 115, KGScreenHeight + 60, 100, 100)];
    self.rightImage.backgroundColor = KGLineColor;
    self.rightImage.contentMode = UIViewContentModeScaleAspectFill;
    self.rightImage.layer.cornerRadius = 5;
    self.rightImage.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.rightImage];
    /** 顶部直线 */
    UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(15, KGScreenHeight + 185, KGScreenWidth - 30, 1)];
    topline.backgroundColor = KGLineColor;
    [self.scrollView addSubview:topline];
    /** 个人资料 */
    UILabel *userInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenHeight + 210, 100, 13)];
    userInfoLab.text = @"个人资料";
    userInfoLab.textColor = KGBlackColor;
    userInfoLab.font = KGFontSHBold(13);
    [self.scrollView addSubview:userInfoLab];
    /** 行业，学校，家乡 */
    NSArray *titleArr = @[@"行业",@"学校",@"家乡"];
    for (int i = 0; i < 3; i++) {
        UILabel *tmpLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenHeight + 250 + 40*i, 50, 12)];
        tmpLab.text = titleArr[i];
        tmpLab.textColor = KGGrayColor;
        tmpLab.font = KGFontSHRegular(12);
        [self.scrollView addSubview:tmpLab];
    }
    self.industryLab = [[UILabel alloc]initWithFrame:CGRectMake(100, KGScreenHeight + 250, KGScreenWidth - 115, 14)];
    self.industryLab.text = @"保卫银河系";
    self.industryLab.textColor = KGBlackColor;
    self.industryLab.font = KGFontSHRegular(14);
    [self.scrollView addSubview:self.industryLab];
    self.schoolLab = [[UILabel alloc]initWithFrame:CGRectMake(100, KGScreenHeight + 290, KGScreenWidth - 115, 14)];
    self.schoolLab.text = @"银河系安全培训中心";
    self.schoolLab.textColor = KGBlackColor;
    self.schoolLab.font = KGFontSHRegular(14);
    [self.scrollView addSubview:self.schoolLab];
    self.hometownLab = [[UILabel alloc]initWithFrame:CGRectMake(100, KGScreenHeight + 330, KGScreenWidth - 115, 14)];
    self.hometownLab.text = @"宇宙 洪荒";
    self.hometownLab.textColor = KGBlackColor;
    self.hometownLab.font = KGFontSHRegular(14);
    [self.scrollView addSubview:self.hometownLab];
    /** 低部直线 */
    UIView *lowline = [[UIView alloc]initWithFrame:CGRectMake(15, KGScreenHeight + 370, KGScreenWidth - 30, 1)];
    lowline.backgroundColor = KGLineColor;
    [self.scrollView addSubview:lowline];
    /** 我的标签 */
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGScreenHeight + 395, 100, 13)];
    myLab.text = @"我的标签";
    myLab.textColor = KGBlackColor;
    myLab.font = KGFontSHBold(13);
    [self.scrollView addSubview:myLab];
}
/** 聊天 */
- (void)chatAction{
    KGChatVC *chatVC = [[KGChatVC alloc]init];
    chatVC.title = @"";
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.targetId = self.sendID;
    chatVC.displayUserNameInCell = YES;
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [self pushHideenTabbarViewController:chatVC animted:YES];
}
/** 关注 */
- (void)focusAction{
    [[KGHUD showMessage:@"关注成功"] hideAnimated:YES afterDelay:1];
}
/** 查看动态 */
- (void)seeDyAction{
    KGSeeFriendsVC *vc = [[KGSeeFriendsVC alloc]init];
    vc.sendID = self.sendID;
    [self pushHideenTabbarViewController:vc animted:YES];
}
/** 创建标签 */
- (void)setLabelWithArr:(NSArray *)arr{
    CGFloat width = 15;
    CGFloat height = KGScreenHeight + 430;
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(width, height, 65, 20)];
        tmp.backgroundColor = KGBlueColor;
        tmp.textColor = KGWhiteColor;
        tmp.layer.cornerRadius = 10;
        tmp.layer.masksToBounds = YES;
        tmp.textAlignment = NSTextAlignmentCenter;
        tmp.text = dic[@"name"];
        tmp.font = KGFontSHRegular(12);
        [self.scrollView addSubview:tmp];
        if ((i + 1)%4 == 0) {
            width = 15;
            height += 35;
        }else{
            width += (KGScreenWidth-290)/3 + 65;
        }
    }
    self.scrollView.contentSize = CGSizeMake(KGScreenWidth, height + 70);
}
/** 滚动视图代理 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.topScrollView) {
        self.pageControl.currentPage = scrollView.contentOffset.x/KGScreenWidth;
    }
}
/** 修改页面 */
- (void)changeUIWithDictionary:(NSDictionary *)dic{
    if (![dic[@"hometown"] isKindOfClass:[NSNull class]]) {
        self.hometownLab.text = dic[@"hometown"];
    }else{
        self.hometownLab.text = @"未知";
    }
    if (![dic[@"industry"] isKindOfClass:[NSNull class]]) {
        self.industryLab.text = dic[@"industry"];
    }else{
        self.industryLab.text = @"未知";
    }
    if (![dic[@"school"] isKindOfClass:[NSNull class]]) {
        self.schoolLab.text = dic[@"school"];
    }else{
        self.schoolLab.text = @"";
    }
    NSArray *tmp = dic[@"mylabels"];
    if (![tmp isKindOfClass:[NSNull class]] && tmp.count > 0) {
        [self setLabelWithArr:tmp];
    }
    [self createScrollViewWithDic:dic];
}
/** 创建滚动图 */
- (void)createScrollViewWithDic:(NSDictionary *)dic{
    if (![dic[@"dynamicImage1"] isKindOfClass:[NSNull class]]) {
        UIImageView *imageOne = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
        [imageOne sd_setImageWithURL:[NSURL URLWithString:dic[@"dynamicImage1"]]];
        imageOne.contentMode = UIViewContentModeScaleAspectFill;
        imageOne.layer.masksToBounds = YES;
        [self.topScrollView addSubview:imageOne];
    }
    if (![dic[@"dynamicImage2"] isKindOfClass:[NSNull class]]) {
        UIImageView *imageOne = [[UIImageView alloc]initWithFrame:CGRectMake(KGScreenWidth, 0, KGScreenWidth, KGScreenHeight)];
        [imageOne sd_setImageWithURL:[NSURL URLWithString:dic[@"dynamicImage2"]]];
        imageOne.contentMode = UIViewContentModeScaleAspectFill;
        imageOne.layer.masksToBounds = YES;
        [self.topScrollView addSubview:imageOne];
    }
    if (![dic[@"dynamicImage3"] isKindOfClass:[NSNull class]]) {
        UIImageView *imageOne = [[UIImageView alloc]initWithFrame:CGRectMake(KGScreenWidth*2, 0, KGScreenWidth, KGScreenHeight)];
        [imageOne sd_setImageWithURL:[NSURL URLWithString:dic[@"dynamicImage3"]]];
        imageOne.contentMode = UIViewContentModeScaleAspectFill;
        imageOne.layer.masksToBounds = YES;
        [self.topScrollView addSubview:imageOne];
    }
}
/** 请求动态 */
- (void)requestQueryData{
    __weak typeof(self) weakSelf = self;
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [KGRequest postWithUrl:ListMessage parameters:@{@"pageSize":@"20",@"pageIndex":@"1",@"uid":self.sendID} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (![tmp isKindOfClass:[NSNull class]]) {
                if (tmp.count > 0 ) {
                    [weakSelf changeWithArr:tmp];
                }
            }else{
                weakSelf.leftImage.image = [UIImage imageNamed:@"kongyemian"];
                weakSelf.centerImage.hidden = YES;
                weakSelf.rightImage.hidden = YES;
            }
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 添加动态 */
- (void)changeWithArr:(NSArray *)arr{
    if (arr.count >= 3) {
        for (int i = 0; i < 3; i++) {
            NSDictionary *dic = arr[i];
            if (i == 0) {
                NSArray *tmp = dic[@"imgs"];
                NSDictionary *imageDic = [tmp firstObject];
                [self.leftImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageUrl"]]];
            }else if (i == 1){
                NSArray *tmp = dic[@"imgs"];
                NSDictionary *imageDic = [tmp firstObject];
                [self.centerImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageUrl"]]];
            }else{
                NSArray *tmp = dic[@"imgs"];
                NSDictionary *imageDic = [tmp firstObject];
                [self.rightImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageUrl"]]];
            }
        }
    }else if (arr.count ==2){
        for (int i = 0; i < 2; i++) {
            NSDictionary *dic = arr[i];
            if (i == 0) {
                NSArray *tmp = dic[@"imgs"];
                NSDictionary *imageDic = [tmp firstObject];
                [self.leftImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageUrl"]]];
            }else{
                NSArray *tmp = dic[@"imgs"];
                NSDictionary *imageDic = [tmp firstObject];
                [self.centerImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageUrl"]]];
            }
            self.rightImage.hidden = YES;
        }
    }else{
        NSDictionary *dic = [arr firstObject];
        NSArray *tmpArr = dic[@"imgs"];
        NSDictionary *imageDic = [tmpArr firstObject];
        [self.leftImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageUrl"]]];
        self.centerImage.hidden = YES;
        self.rightImage.hidden = YES;
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
