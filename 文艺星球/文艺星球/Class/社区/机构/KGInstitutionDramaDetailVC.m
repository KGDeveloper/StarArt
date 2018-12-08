//
//  KGInstitutionDramaDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionDramaDetailVC.h"

@interface KGInstitutionDramaDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *customBackImage;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *dramaNameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *presonLab;
@property (nonatomic,copy) NSDictionary *userDic;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lowHeight;

@end

@implementation KGInstitutionDramaDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:[UIColor clearColor] controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    
    [self requestData];
}
/** 请求数据 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectShowBySID parameters:@{@"id":self.sendID} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            weakSelf.userDic = result[@"data"];
        }
        [weakSelf changeUIData];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [weakSelf changeUIData];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)locationAction:(UIButton *)sender {
    
}
/** 设置内容 */
- (void)changeUIData{
    [self.customBackImage sd_setImageWithURL:[NSURL URLWithString:[[self.userDic[@"showCover"] componentsSeparatedByString:@"#"] firstObject]]];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[[self.userDic[@"showCover"] componentsSeparatedByString:@"#"] firstObject]]];
    self.nameLab.text = self.userDic[@"showPlace"];
    self.timeLab.text = self.userDic[@"showTime"];
    self.addressLab.text = self.userDic[@"showAddress"];
    self.dramaNameLab.text = self.userDic[@"showTitle"];
    self.detailLab.text = self.userDic[@"showIntroduction"];
    self.detailHeight.constant = [self.userDic[@"showIntroduction"] boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(13)} context:nil].size.height + 30;
    self.maskView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.6];
    [self.view sendSubviewToBack:self.maskView];
    [self.view sendSubviewToBack:self.customBackImage];
    
    NSData *jsonData = [self.userDic[@"showPrecautions"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *tmpArr = dic[@"showPrecautions"];
    NSString *presonStr = [NSString stringWithFormat:@"注意事项：\n演出时长：%@\n演出地点：%@\n演出时间：%@\n其他注意事项：%@",dic[@"showDuration"],dic[@"showPlace"],dic[@"showTime"],[tmpArr firstObject]];
    self.presonLab.text = presonStr;
    self.lowHeight.constant = [presonStr boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(13)} context:nil].size.height + 30;
    
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
