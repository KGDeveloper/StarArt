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

@interface KGSubmitLocationInfoVC ()<UITableViewDelegate,UITableViewDataSource>
/** 信息 */
@property (nonatomic,strong) UITableView *listView;
/** 协议 */
@property (nonatomic,strong) UIButton *chooseBtu;
/** 提交 */
@property (nonatomic,strong) UIButton *submitBtu;
/** 标题 */
@property (nonatomic,copy) NSArray *titleArr;

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
    self.submitBtu.backgroundColor = KGGrayColor;
    self.submitBtu.userInteractionEnabled = NO;
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
        return cell;
    }else{
        KGSubmitLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSubmitLocationCell" forIndexPath:indexPath];
        cell.titleLab.text = self.titleArr[indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1){/** 英文名称以及中文名称 */
        KGTheNameOfThePlaceVC *vc = [[KGTheNameOfThePlaceVC alloc]initWithNibName:@"KGTheNameOfThePlaceVC" bundle:nil];
        vc.sendPlaceName = ^(NSString * _Nonnull chinaName, NSString * _Nonnull englishName) {
            
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 2){/** 副标题 */
        KGTheDetailNameOfThePlaceVC *vc = [[KGTheDetailNameOfThePlaceVC alloc]initWithNibName:@"KGTheDetailNameOfThePlaceVC" bundle:nil];
        vc.sendDetailString = ^(NSString * _Nonnull detailString) {
            
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 3){/** 简介 */
        KGTheIntroduceOfThePlaceVC *vc = [[KGTheIntroduceOfThePlaceVC alloc]init];
        vc.sendIntroduce = ^(NSString * _Nonnull introduceString) {
            
        };
        [self pushHideenTabbarViewController:vc animted:YES];
    }else if (indexPath.row == 4){/** 详细介绍 */
        
    }else if (indexPath.row == 5){/** 地点类型 */
        
    }else if (indexPath.row == 6){/** 所在城市 */
        
    }else if (indexPath.row == 7){/** 详细地址 */
        
    }else if (indexPath.row == 8){/** 联系电话 */
        
    }else if (indexPath.row == 9){/** 营业时间 */
        
    }else{/** 人均消费 */
        
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
