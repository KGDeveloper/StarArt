//
//  KGMineVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGMineVC.h"
#import "KGMineDoubleCell.h"
#import "KGMineSingleCell.h"
#import "KGIntegralVC.h"
#import "KGSetUpAppVC.h"
#import "KGTalentShowVC.h"
#import "KGEditSelfVC.h"
#import "KGContellionVC.h"
#import "KGSeeFriendsVC.h"

@interface KGMineVC ()<UITableViewDelegate,UITableViewDataSource,KGMineDoubleDelegate,KGMineSingleCellDelegate>
/** 头像 */
@property (nonatomic,strong) UIImageView *headerImage;
/** 昵称 */
@property (nonatomic,strong) UILabel *nikeName;
/** 签名 */
@property (nonatomic,strong) UILabel *signatureLab;
/** 年龄以及性别 */
@property (nonatomic,strong) UIButton *ageAndSex;
/** 设置列表 */
@property (nonatomic,strong) UITableView *listView;
/** 标签数组 */
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation KGMineVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self changeNavBackColor:[UIColor clearColor] controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self setBackView];
    [self setHeaderView];
    [self setListView];
}
/** 创建背景 */
- (void)setBackView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"gerenzhongxin"];
    [self.view addSubview:imageView];
}
/** 设置头像,昵称，签名，年龄 */
- (void)setHeaderView{
    /** 设置头像 */
    self.headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(36, 85, 79, 79)];
    if ([KGUserInfo shareInstance].userPortrait) {
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[KGUserInfo shareInstance].userPortrait]];
    }else{
        self.headerImage.backgroundColor = KGLineColor;
    }
    self.headerImage.layer.cornerRadius = 37.5;
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.layer.borderColor = KGWhiteColor.CGColor;
    self.headerImage.layer.borderWidth = 1;
    [self.view addSubview:self.headerImage];
    /** 设置昵称 */
    self.nikeName = [[UILabel alloc]initWithFrame:CGRectMake(36, 174, 100, 15)];
    self.nikeName.text = [KGUserInfo shareInstance].userName;
    self.nikeName.textColor = KGBlackColor;
    self.nikeName.font = KGFontSHRegular(15);
    [self.view addSubview:self.nikeName];
    /** 设置签名 */
    self.signatureLab = [[UILabel alloc]initWithFrame:CGRectMake(36, 194, KGScreenWidth - 96, 11)];
    self.signatureLab.textColor = KGBlackColor;
    self.signatureLab.text = [KGUserInfo shareInstance].userPersonalitySignature;
    self.signatureLab.font = KGFontSHRegular(11);
    [self.view addSubview:self.signatureLab];
    /** 设置年龄 */
    self.ageAndSex = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ageAndSex.frame = CGRectMake([self calculateWidthWithString:self.nikeName.text font:KGFontSHRegular(15)] + 46, 174, 35, 15);
    [self.ageAndSex setTitle:[NSString stringWithFormat:@"%@",[KGUserInfo shareInstance].userAge] forState:UIControlStateNormal];
    self.ageAndSex.titleLabel.font = KGFontSHRegular(11);
    if ([[KGUserInfo shareInstance].userSex integerValue] == 0) {
        [self.ageAndSex setImage:[UIImage imageNamed:@"xingbienv"] forState:UIControlStateNormal];
        self.ageAndSex.backgroundColor = KGWomanColor;
    }else if ([[KGUserInfo shareInstance].userSex integerValue] == 1){
        [self.ageAndSex setImage:[UIImage imageNamed:@"xingbienan"] forState:UIControlStateNormal];
        self.ageAndSex.backgroundColor = KGManColor;
    }else{
        [self.ageAndSex setImage:[UIImage imageNamed:@"xingbiebaomi"] forState:UIControlStateNormal];
        self.ageAndSex.backgroundColor = KGManColor;
    }
    self.ageAndSex.userInteractionEnabled = NO;
    self.ageAndSex.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.ageAndSex.layer.cornerRadius = 2;
    self.ageAndSex.layer.masksToBounds = YES;
    [self.view addSubview:self.ageAndSex];
    /** 编辑按钮 */
    UIButton *editBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtu.frame = CGRectMake(KGScreenWidth - 50, 169, 35, 35);
    [editBtu setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
    editBtu.layer.cornerRadius = 17.5;
    editBtu.layer.masksToBounds = YES;
    [editBtu addTarget:self action:@selector(editSelfInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtu];
}
/** 编辑按钮点击事件 */
- (void)editSelfInfo{
    [self pushHideenTabbarViewController:[[KGEditSelfVC alloc]init] animted:YES];
}
/** 设置列表 */
- (void)setListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 245, KGScreenWidth, KGScreenHeight - 245 - KGRectTabbarHeight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.scrollEnabled = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listView registerClass:[KGMineDoubleCell class] forCellReuseIdentifier:@"KGMineDoubleCell"];
    [self.listView registerClass:[KGMineSingleCell class] forCellReuseIdentifier:@"KGMineSingleCell"];
    [self.view addSubview:self.listView];
    
    self.dataArr = @[@{@"topleftImage":@"wodeshoucang",@"toprightImage":@"dakai",@"toptitle":@"我的收藏",@"lowleftImage":@"wodejifen",@"lowrightImage":@"dakai",@"lowtitle":@"我的积分"},@{@"topleftImage":@"wodedaren",@"toprightImage":@"dakai",@"toptitle":@"我的达人",@"lowleftImage":@"wodedongtai",@"lowrightImage":@"dakai",@"lowtitle":@"我的动态"}];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        return 110;
    }else{
        return 60;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        KGMineDoubleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGMineDoubleCell"];
        if (!cell) {
            cell = [[KGMineDoubleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KGMineDoubleCell"];
        }
        cell.infoDic = self.dataArr[indexPath.row];
        cell.delegate = self;
        return cell;
    }else{
        KGMineSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGMineSingleCell"];
        if (!cell) {
            cell = [[KGMineSingleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KGMineSingleCell"];
        }
        cell.infoDic = @{@"leftImage":@"wodeshezhi",@"rightImage":@"dakai",@"title":@"我的设置"};
        cell.delegate = self;
        return cell;
    }
}
/** cell代理点击事件 */
- (void)selectViewWithTitile:(NSString *)title{
    if ([title isEqualToString:@"我的设置"]) {
        [self pushHideenTabbarViewController:[[KGSetUpAppVC alloc]init] animted:YES];
    }else if ([title isEqualToString:@"我的收藏"]){
        [self pushHideenTabbarViewController:[[KGContellionVC alloc]init] animted:YES];
    }else if ([title isEqualToString:@"我的积分"]){
        [self pushHideenTabbarViewController:[[KGIntegralVC alloc]initWithNibName:@"KGIntegralVC" bundle:nil] animted:YES];
    }else if ([title isEqualToString:@"我的达人"]){
        [self pushHideenTabbarViewController:[[KGTalentShowVC alloc]initWithNibName:@"KGTalentShowVC" bundle:nil] animted:YES];
    }else if ([title isEqualToString:@"我的动态"]){
        KGSeeFriendsVC *vc = [[KGSeeFriendsVC alloc]init];
        vc.sendID = [KGUserInfo shareInstance].userId;
        [self pushHideenTabbarViewController:vc animted:YES];
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
