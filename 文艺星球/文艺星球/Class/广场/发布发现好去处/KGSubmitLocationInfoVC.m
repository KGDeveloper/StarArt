//
//  KGSubmitLocationInfoVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSubmitLocationInfoVC.h"
#import "KGSubmitLocationCell.h"
#import "KGSubmitMapCell.h"
#import "KGTheNameOfThePlaceVC.h"
#import "KGTheDetailNameOfThePlaceVC.h"
#import "KGTheIntroduceOfThePlaceVC.h"
#import "KGDetailedIntroductionOfThePlaceVC.h"
#import "KGSelectTheCategoryOfThePlaceVC.h"
#import "KGWhereTheCityOfTheCityVC.h"
#import "KGTheTelphoneOfThePlaceVC.h"
#import "KGBusinessHoursOfThePlaceVC.h"
#import "KGPerCapitaConsumptionOfThePlaceVC.h"
#import "KGRecommendPlaceAggremmentVC.h"
#import "KGPlaceTheCoverVC.h"
#import "KGDetailedAddressOfThePlaceVC.h"

@interface KGSubmitLocationInfoVC ()<UITableViewDelegate,UITableViewDataSource>
/** 信息 */
@property (nonatomic,strong) UITableView *listView;
/** 协议 */
@property (nonatomic,strong) UIButton *chooseBtu;
/** 提交 */
@property (nonatomic,strong) UIButton *submitBtu;
/** 标题 */
@property (nonatomic,copy) NSArray *titleArr;
/** 地址图片 */
@property (nonatomic,copy) UIImage *cellImage;
/** 用户发布好去处 */
@property (nonatomic,strong) NSMutableDictionary *userDic;
/** 封面 */
@property (nonatomic,copy) UIImage *coverImage;
/** 介绍图片 */
@property (nonatomic,copy) NSMutableArray *imageArr;
@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation KGSubmitLocationInfoVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGBlueColor controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"提交地点信息";
    self.view.backgroundColor = KGWhiteColor;
    self.titleArr = @[@"地点封面",@"地点名称",@"地点副标题",@"地点简介",@"详细介绍",@"地点类型",@"所在城市",@"",@"联系电话",@"营业时间",@"人均消费"];
    self.userDic = [NSMutableDictionary dictionary];
    [self setUpListView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建listView */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0,KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.backgroundColor = KGWhiteColor;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.tableHeaderView = [self setHeaderView];
    self.listView.tableFooterView = [self setFootView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGSubmitLocationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGSubmitLocationCell"];
    [self.listView registerClass:[KGSubmitMapCell class] forCellReuseIdentifier:@"KGSubmitMapCell"];
}
/** 创建头部视图 */
- (UIView *)setHeaderView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 34)];
    UILabel *alertLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, KGScreenWidth - 30, 14)];
    alertLab.text = @"以下为必填项目";
    alertLab.textAlignment = NSTextAlignmentLeft;
    alertLab.textColor = KGBlueColor;
    alertLab.font = KGFontSHRegular(14);
    [backView addSubview:alertLab];
    return backView;
}
/** 创建尾部视图 */
- (UIView *)setFootView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 220)];
    /** 同意协议 */
    self.chooseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseBtu.frame = CGRectMake(15, 20, 15, 15);
    [self.chooseBtu setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [self.chooseBtu addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.chooseBtu];
    /** 协议 */
    YYLabel *aggrementLab = [[YYLabel alloc]initWithFrame:CGRectMake(35, 21.5, KGScreenWidth - 60, 12)];
    [backView addSubview:aggrementLab];
    /** 设置富文本 */
    NSString *string = @"请确认图片文字由您本人拍摄撰写，点击查看具体说明";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    attributedString.alignment = NSTextAlignmentLeft;
    attributedString.font = KGFontSHRegular(12);
    attributedString.color = KGBlackColor;
    [attributedString setColor:KGBlueColor range:[string rangeOfString:@"具体说明"]];
    __weak typeof(self) weakSelf = self;
    /** 点击用户协议 */
    [attributedString setTextHighlightRange:[string rangeOfString:@"具体说明"] color:KGBlueColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf pushHideenTabbarViewController:[[KGRecommendPlaceAggremmentVC alloc]init] animted:YES];
        });
    }];
    aggrementLab.attributedText = attributedString;
    /** 提交按钮 */
    self.submitBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtu.frame = CGRectMake((KGScreenWidth - 245)/2, 82,245 ,35);
    [self.submitBtu setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtu setTitleColor:KGWhiteColor forState:UIControlStateNormal];
    self.submitBtu.titleLabel.font = KGFontSHRegular(15);
    [self.submitBtu addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtu.backgroundColor = KGBlueColor;
    self.submitBtu.layer.cornerRadius = 17.5;
    self.submitBtu.layer.masksToBounds = YES;
    [backView addSubview:self.submitBtu];
    return backView;
}
/** 同意协议 */
- (void)chooseAction:(UIButton *)sender{
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"weixuanzhong"]]) {
        [sender setImage:[UIImage imageNamed:@"fuhao"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
}
/** 提交 */
- (void)chooseAction{
    if (![self.chooseBtu.currentImage isEqual:[UIImage imageNamed:@"weixuanzhong"]]) {
        self.hud  = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof(self) weakSelf = self;
        __block NSMutableArray *tmp = [NSMutableArray array];
        dispatch_queue_t queue = dispatch_queue_create("封面", DISPATCH_QUEUE_SERIAL);
        dispatch_sync(queue, ^{
            [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.coverImage] result:^(NSString * _Nonnull strPath) {
                [weakSelf.userDic setObject:strPath forKey:@"image"];
                [weakSelf releaseWithArr];
            }];
        });
        dispatch_queue_t queueImage = dispatch_queue_create("介绍", DISPATCH_QUEUE_SERIAL);
        dispatch_sync(queueImage, ^{
            for (int i = 0; i < self.imageArr.count; i++) {
                [[KGRequest shareInstance] uploadImageToQiniuWithFile:[[KGRequest shareInstance] getImagePath:self.imageArr[i]] result:^(NSString * _Nonnull strPath) {
                    [tmp addObject:strPath];
                    if (weakSelf.imageArr.count == tmp.count) {
                        [weakSelf.userDic setObject:tmp.copy forKey:@"images"];
                        [weakSelf releaseWithArr];
                    }
                }];
            }
        });
    }else{
        [[KGHUD showMessage:@"请先阅读说明协议"] hideAnimated:YES afterDelay:1];
    }
}
/** 发布 */
- (void)releaseWithArr{
    __weak typeof(self) weakSelf = self;
    [self.userDic setObject:[KGUserInfo shareInstance].userId forKey:@"uid"];
    if (self.userDic[@"placenameeh"]) {
        if (self.userDic.count == 18) {
            [KGRequest postWithUrl:SaveGoodPlace parameters:self.userDic succ:^(id  _Nonnull result) {
                if ([result[@"status"] integerValue] == 200) {
                    [weakSelf.hud hideAnimated:YES];
                    [[KGHUD showMessage:@"发布成功"] hideAnimated:YES afterDelay:1];
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [[KGHUD showMessage:@"发布失败"] hideAnimated:YES afterDelay:1];
                }
            } fail:^(NSError * _Nonnull error) {
                [[KGHUD showMessage:@"发布失败"] hideAnimated:YES afterDelay:1];
            }];
        }
    }else{
        if (self.userDic.count == 17) {
            [KGRequest postWithUrl:SaveGoodPlace parameters:self.userDic succ:^(id  _Nonnull result) {
                if ([result[@"status"] integerValue] == 200) {
                    [weakSelf.hud hideAnimated:YES];
                    [[KGHUD showMessage:@"发布成功"] hideAnimated:YES afterDelay:1];
                }else{
                    [[KGHUD showMessage:@"发布失败"] hideAnimated:YES afterDelay:1];
                }
            } fail:^(NSError * _Nonnull error) {
                [[KGHUD showMessage:@"发布失败"] hideAnimated:YES afterDelay:1];
            }];
        }
    }
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 7) {
        return (KGScreenWidth - 30)/690*260 + 70;
    }else{
        return 50;
    }
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 7) {
        KGSubmitMapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSubmitMapCell"];
        if (self.cellImage) {
            cell.resultImage = self.cellImage;
        }
        return cell;
    }else{
        KGSubmitLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSubmitLocationCell" forIndexPath:indexPath];
        cell.titleLab.text = self.titleArr[indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {/** 选择封面 */
        KGPlaceTheCoverVC *vc = [[KGPlaceTheCoverVC alloc]initWithNibName:@"KGPlaceTheCoverVC" bundle:nil];
        vc.sendPlaceTheCover = ^(UIImage * _Nonnull coverImage) {
            weakSelf.coverImage = coverImage;
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 1){/** 英文名称以及中文名称 */
        KGTheNameOfThePlaceVC *vc = [[KGTheNameOfThePlaceVC alloc]initWithNibName:@"KGTheNameOfThePlaceVC" bundle:nil];
        vc.sendPlaceName = ^(NSString * _Nonnull chinaName, NSString * _Nonnull englishName) {
            if (englishName != nil) {
                [weakSelf.userDic setObject:englishName forKey:@"placenameeh"];
            }
            [weakSelf.userDic setObject:chinaName forKey:@"placenameca"];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 2){/** 副标题 */
        KGTheDetailNameOfThePlaceVC *vc = [[KGTheDetailNameOfThePlaceVC alloc]initWithNibName:@"KGTheDetailNameOfThePlaceVC" bundle:nil];
        vc.sendDetailString = ^(NSString * _Nonnull detailString) {
            [weakSelf.userDic setObject:detailString forKey:@"title"];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 3){/** 简介 */
        KGTheIntroduceOfThePlaceVC *vc = [[KGTheIntroduceOfThePlaceVC alloc]init];
        vc.sendIntroduce = ^(NSString * _Nonnull introduceString) {
            [weakSelf.userDic setObject:introduceString forKey:@"synopsis"];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 4){/** 详细介绍 */
        KGDetailedIntroductionOfThePlaceVC *vc = [[KGDetailedIntroductionOfThePlaceVC alloc]init];
        vc.sendDetailedIntroduction = ^(NSString * _Nonnull introduce, NSArray<UIImage *> * _Nonnull photos) {
            [weakSelf.userDic setObject:introduce forKey:@"introduce"];
            weakSelf.imageArr = [NSMutableArray arrayWithArray:photos];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 5){/** 地点类型 */
        KGSelectTheCategoryOfThePlaceVC *vc = [[KGSelectTheCategoryOfThePlaceVC alloc]init];
        vc.sendChooseSelectString = ^(NSString * _Nonnull imageUrl, NSInteger typeId, NSString * _Nonnull name) {
            [weakSelf.userDic setObject:imageUrl forKey:@"icon"];
            [weakSelf.userDic setObject:@(typeId) forKey:@"type"];
            [weakSelf.userDic setObject:name forKey:@"typeName"];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 6){/** 所在城市 */
        KGWhereTheCityOfTheCityVC *vc = [[KGWhereTheCityOfTheCityVC alloc]init];
        vc.sendChooseCity = ^(NSString *city) {
            [weakSelf.userDic setObject:city forKey:@"city"];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 7){/** 详细地址 */
        KGDetailedAddressOfThePlaceVC *vc = [[KGDetailedAddressOfThePlaceVC alloc]init];
        vc.sendDetailedAddress = ^(NSString * _Nonnull address, UIImage * _Nonnull resultImage, CLLocationCoordinate2D location) {
            weakSelf.cellImage = resultImage;
            [weakSelf.userDic setObject:address forKey:@"location"];
            [weakSelf.userDic setObject:@(location.latitude) forKey:@"latitude"];
            [weakSelf.userDic setObject:@(location.latitude) forKey:@"longitude"];
            [weakSelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 8){/** 联系电话 */
        KGTheTelphoneOfThePlaceVC *vc = [[KGTheTelphoneOfThePlaceVC alloc]initWithNibName:@"KGTheTelphoneOfThePlaceVC" bundle:nil];
        vc.sendTheOfficialTelphone = ^(NSString * _Nonnull telphone) {
            [weakSelf.userDic setObject:telphone forKey:@"tel"];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 9){/** 营业时间 */
        KGBusinessHoursOfThePlaceVC *vc = [[KGBusinessHoursOfThePlaceVC alloc]initWithNibName:@"KGBusinessHoursOfThePlaceVC" bundle:nil];
        vc.sendBusinessTime = ^(NSString * _Nonnull timeStr) {
            [weakSelf.userDic setObject:timeStr forKey:@"businessHours"];
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else{/** 人均消费 */
        KGPerCapitaConsumptionOfThePlaceVC *vc = [[KGPerCapitaConsumptionOfThePlaceVC alloc]initWithNibName:@"KGPerCapitaConsumptionOfThePlaceVC" bundle:nil];
        vc.sendPriceString = ^(NSString * _Nonnull price) {
            [weakSelf.userDic setObject:price forKey:@"consumption"];
        };
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
