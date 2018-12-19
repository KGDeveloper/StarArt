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
#import "KGSquareDetailVC.h"

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
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) PhotosLibraryView *photoLibary;

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
    self.view.backgroundColor = KGWhiteColor;
    self.dataArr = [NSMutableArray array];
    self.page = 1;
    
    [self requestData];
    [self requestUserHeader];
    [self setUpListView];
}
/** 查看个人头像 */
- (void)requestUserHeader{
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:[RequestUserInfo stringByAppendingString:[NSString stringWithFormat:@"/%@",@([self.sendID integerValue])]] parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            [weakSelf.backHeaderImage sd_setImageWithURL:[NSURL URLWithString:dic[@"coverImage"]]];
            [weakSelf.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        }
    } fail:^(NSError * _Nonnull error) {
        
    }];
}
/** 查看动态 */
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [KGRequest postWithUrl:ListMessage parameters:@{@"pageSize":@"20",@"pageIndex":@(self.page),@"uid":self.sendID} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (![tmp isKindOfClass:[NSNull class]]) {
                if (tmp.count > 0 ) {
                    [weakSelf.dataArr addObjectsFromArray:tmp];
                    NSDictionary *dic = [weakSelf.dataArr firstObject];
                    [weakSelf.backHeaderImage sd_setImageWithURL:[NSURL URLWithString:dic[@"userPortraitUri"]]];
                    [weakSelf.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"userPortraitUri"]]];
                    weakSelf.nameLab.text = dic[@"userName"];
                    weakSelf.signaturlLab.text = dic[@"personalitySignature"];
                }
            }
        }
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView reloadData];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 导航栏返回按钮点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
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
    __weak typeof(self) weakSelf = self;
    self.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.dataArr = [NSMutableArray array];
        [weakSelf.listView.mj_header beginRefreshing];
        [weakSelf requestData];
    }];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf.listView.mj_footer beginRefreshing];
        [weakSelf requestData];
    }];
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
    self.backHeaderImage.layer.masksToBounds = YES;
    self.backHeaderImage.backgroundColor = KGGrayColor;
    self.backHeaderImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBackImage)];
    [self.backHeaderImage addGestureRecognizer:tap];
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
    self.nameLab.text = @"";
    self.nameLab.textColor = KGWhiteColor;
    self.nameLab.font = KGFontSHRegular(14);
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    [hedaerView addSubview:self.nameLab];
    /** 签名 */
    self.signaturlLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.nameLab.frame.origin.y + 24, KGScreenWidth, 11)];
    self.signaturlLab.text = @"";
    self.signaturlLab.textColor = KGWhiteColor;
    self.signaturlLab.font = KGFontSHRegular(11);
    self.signaturlLab.textAlignment = NSTextAlignmentCenter;
    [hedaerView addSubview:self.signaturlLab];
    return hedaerView;
}
/** 修改背景 */
- (void)chooseBackImage{
    if ([self.sendID integerValue] == [[KGUserInfo shareInstance].userId integerValue]) {
        self.photoLibary.hidden = NO;
    }
}
/** 选择照片 */
- (PhotosLibraryView *)photoLibary{
    if (!_photoLibary) {
        _photoLibary = [[PhotosLibraryView alloc]initWithFrame:CGRectMake(0,0, KGScreenWidth, KGScreenHeight)];
        _photoLibary.maxCount = 1;
        __weak typeof(self) weakSelf = self;
        _photoLibary.chooseImageFromPhotoLibary = ^(NSArray<UIImage *> *imageArr) {
            [weakSelf changeBackImageWithImage:[imageArr firstObject]];
            weakSelf.backHeaderImage.image = [imageArr firstObject];
        };
        [self.navigationController.view insertSubview:_photoLibary atIndex:99];
    }
    return _photoLibary;
}
/** 修改背景 */
- (void)changeBackImageWithImage:(UIImage *)image{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:image] result:^(NSString * _Nonnull strPath) {
        [KGRequest postWithUrl:UpdateUserInfo parameters:@{@"coverImage":strPath,@"portraitUri":[KGUserInfo shareInstance].userPortrait} succ:^(id  _Nonnull result) {
            [hud hideAnimated:YES];
            if ([result[@"status"] integerValue] == 200) {
                [[KGHUD showMessage:@"修改成功"] hideAnimated:YES afterDelay:1];
            }else{
                [[KGHUD showMessage:@"请求出错，请重试！"] hideAnimated:YES afterDelay:1];
            }
        } fail:^(NSError * _Nonnull error) {
            [hud hideAnimated:YES];
            [[KGHUD showMessage:@"请求出错，请重试！"] hideAnimated:YES afterDelay:1];
        }];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    if ([dic[@"composing"] integerValue] == 2) {
        KGSquareRoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareRoundCell"];
        return [cell rowHeightWithDictionary:dic];
    }else if ([dic[@"composing"] integerValue] == 0 || [dic[@"composing"] integerValue] == 1){
        KGQuareHorizontalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGQuareHorizontalCell"];
        return [cell rowHeightWithDictionary:dic];
    }else{
        KGSquareVerticalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareVerticalCell"];
        return [cell rowHeightWithDictionary:dic];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    if ([dic[@"composing"] integerValue] == 2) {
        KGSquareRoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareRoundCell"];
        [cell cellDataWithDictionary:dic];
        return cell;
    }else if ([dic[@"composing"] integerValue] == 0 || [dic[@"composing"] integerValue] == 1){
        KGQuareHorizontalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGQuareHorizontalCell"];
        [cell cellDataWithDictionary:dic];
        return cell;
    }else{
        KGSquareVerticalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareVerticalCell"];
        [cell cellDataWithDictionary:dic];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    KGSquareDetailVC *vc = [[KGSquareDetailVC alloc]init];
    vc.newsId = [NSString stringWithFormat:@"%@",dic[@"id"]];
    [self pushHideenTabbarViewController:vc animted:YES];
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
