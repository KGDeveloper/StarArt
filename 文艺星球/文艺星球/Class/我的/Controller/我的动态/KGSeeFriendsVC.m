//
//  KGSeeFriendsVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSeeFriendsVC.h"
#import "KGSquareRoundCell.h"
#import "KGSquareVerticalCell.h"
#import "KGQuareHorizontalCell.h"

@interface KGSeeFriendsVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 消息 */
@property (nonatomic,strong) UITableView *listView;
/** 背景头像 */
@property (nonatomic,strong) UIImageView *backHeaderImage;
/** 头像 */
@property (nonatomic,strong) UIImageView *headerImage;
/** 昵称 */
@property (nonatomic,strong) UILabel *nameLab;
/** 签名 */
@property (nonatomic,strong) UILabel *signaturlLab;

@end

@implementation KGSeeFriendsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    if (![self.isShow isEqualToString:@"隐藏"]) {
        [self setRightNavItemWithFrame:CGRectZero title:@"关注" image:nil font:KGFontSHRegular(12) color:KGWhiteColor select:@selector(rightNavAction:)];
        self.rightNavItem.backgroundColor = KGBlueColor;
        self.rightNavItem.layer.cornerRadius = 5;
        self.rightNavItem.layer.masksToBounds = YES;
        self.rightNavItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    self.view.backgroundColor = KGWhiteColor;
    
    [self requestData];
    [self setUpListView];
}
/** 查看动态 */
- (void)requestData{
    [KGRequest postWithUrl:ListMessage parameters:@{@"pageSize":@"20",@"pageIndex":@"1",@"uid":[KGUserInfo shareInstance].userId} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            
        }
    } fail:^(NSError * _Nonnull error) {
        
    }];
}
/** 导航栏返回按钮点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏关注按钮点击事件 */
- (void)rightNavAction:(UIButton *)sender{
    
}
/** 创建消息列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    self.listView.dataSource = self;
    self.listView.delegate = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    if (@available(iOS 11.0, *)) {
        self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setUpHeaderView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    
    [self.listView registerClass:[KGSquareRoundCell class] forCellReuseIdentifier:@"KGSquareRoundCell"];
    [self.listView registerClass:[KGQuareHorizontalCell class] forCellReuseIdentifier:@"KGQuareHorizontalCell"];
    [self.listView registerClass:[KGSquareVerticalCell class] forCellReuseIdentifier:@"KGSquareVerticalCell"];
}
/** 用户消息 */
- (UIView *)setUpHeaderView{
    UIView *hedaerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/750*470)];
    hedaerView.backgroundColor = KGLineColor;
    /** 背景头像 */
    self.backHeaderImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenWidth/750*470 - 10)];
    self.backHeaderImage.contentMode = UIViewContentModeScaleAspectFill;
    self.backHeaderImage.backgroundColor = KGGrayColor;
    [hedaerView addSubview:self.backHeaderImage];
    /** 头像 */
    self.headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(KGScreenWidth/2 - 30, hedaerView.bounds.size.height - 140, 60, 60)];
    self.headerImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImage.backgroundColor = KGBlueColor;
    self.headerImage.layer.cornerRadius = 30;
    self.headerImage.layer.borderColor = KGLineColor.CGColor;
    self.headerImage.layer.borderWidth = 2;
    self.headerImage.layer.masksToBounds = YES;
    [hedaerView addSubview:self.headerImage];
    /** 昵称 */
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.headerImage.frame.origin.y + 70, KGScreenWidth, 14)];
    self.nameLab.text = @"啊哈哈哈";
    self.nameLab.textColor = KGWhiteColor;
    self.nameLab.font = KGFontSHRegular(14);
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    [hedaerView addSubview:self.nameLab];
    /** 签名 */
    self.signaturlLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.nameLab.frame.origin.y + 24, KGScreenWidth, 11)];
    self.signaturlLab.text = @"曾经沧海难为水，除却巫山不是云";
    self.signaturlLab.textColor = KGWhiteColor;
    self.signaturlLab.font = KGFontSHRegular(11);
    self.signaturlLab.textAlignment = NSTextAlignmentCenter;
    [hedaerView addSubview:self.signaturlLab];
    return hedaerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        KGSquareRoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareRoundCell"];
        return cell;
    }else if (indexPath.row == 1){
        KGQuareHorizontalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGQuareHorizontalCell"];
        return cell;
    }else{
        KGSquareVerticalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareVerticalCell"];
        return cell;
    }
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
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
