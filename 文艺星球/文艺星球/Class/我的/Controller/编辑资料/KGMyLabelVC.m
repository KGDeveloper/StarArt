//
//  KGMyLabelVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGMyLabelVC.h"

@interface KGMyLabelVC ()
/** 已选择 */
@property (nonatomic,strong) UIButton *chooseBtu;
/** 选一批 */
@property (nonatomic,strong) UIButton *changeBtu;
/** 数量 */
@property (nonatomic,strong) UILabel *countLab;
/** 加载标签view */
@property (nonatomic,strong) UIView *addView;
/** 选择的标签 */
@property (nonatomic,strong) NSMutableSet *titleArr;
/** 已选择view */
@property (nonatomic,strong) UIView *chooseView;
/** 地板 */
@property (nonatomic,strong) UIView *chooseBack;

@end

@implementation KGMyLabelVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:KGBlueColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGWhiteColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"我的标签";
    self.view.backgroundColor = KGWhiteColor;
    self.titleArr = [NSMutableSet set];
    if (self.oldArr.count > 0) {
        [self.titleArr addObjectsFromArray:self.oldArr];
    }
    [self requestLabels];
    [self setUI];
    
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.titleArr.count > 0) {
        if (self.sendChooseLabel) {
            NSArray *tmp = [self.titleArr allObjects];
            self.sendChooseLabel(tmp.copy);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[KGHUD showMessage:@"请选择标签"] hideAnimated:YES afterDelay:1];
    }
}
/** 请求标签 */
- (void)requestLabels{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:[NSString stringWithFormat:@"%@/10",RandomLabel] parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            [weakSelf setAddViewSubViews:dic[@"list"] toView:self.addView];
        }
        [hud hideAnimated:YES];
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 搭建ui */
- (void)setUI{
    /** 个性标签 */
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight, [self calculateWidthWithString:@"您的个性标签：" font:KGFontSHRegular(14)], 50)];
    titleLab.text = @"您的个性标签：";
    titleLab.font = KGFontSHRegular(14);
    titleLab.textColor = KGBlackColor;
    [self.view addSubview:titleLab];
    /** 数量统计 */
    self.countLab = [[UILabel alloc]initWithFrame:CGRectMake(KGScreenWidth - 60, KGRectNavAndStatusHight, 45, 50)];
    self.countLab.text = [NSString stringWithFormat:@"%lu/15",(unsigned long)self.titleArr.count];
    self.countLab.textColor = KGGrayColor;
    self.countLab.font = KGFontSHRegular(14);
    self.countLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.countLab];
    /** 已选择 */
    self.chooseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseBtu.frame = CGRectMake(titleLab.frame.size.width + 15, KGRectNavAndStatusHight, KGScreenWidth - titleLab.frame.size.width - 75, 50);
    [self.chooseBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.chooseBtu.titleLabel.font = KGFontSHRegular(14);
    self.chooseBtu.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.chooseBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.chooseBtu addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseBtu];
    /** 分割线 */
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 50, KGScreenWidth, 1)];
    line.backgroundColor = KGLineColor;
    [self.view addSubview:line];
    /** 换一批 */
    self.changeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeBtu.frame = CGRectMake(0, 0, 100, 30);
    self.changeBtu.center = CGPointMake(KGScreenWidth/2, KGScreenHeight - 50);
    [self.changeBtu setTitle:@"换一批" forState:UIControlStateNormal];
    self.changeBtu.backgroundColor = KGBlueColor;
    [self.changeBtu setTitleColor:KGWhiteColor forState:UIControlStateNormal];
    self.changeBtu.titleLabel.font = KGFontSHRegular(14);
    self.changeBtu.layer.cornerRadius = 15;
    self.changeBtu.layer.masksToBounds = YES;
    [self.changeBtu addTarget:self action:@selector(changeLabelTitle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeBtu];
    /** 加载标签 */
    self.addView = [[UIView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 50, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 150)];
    [self.view addSubview:self.addView];
    [self changeChooseBtuTitile];
}
/** 已选择点击事件 */
- (void)chooseAction{
    self.chooseView.hidden = NO;
    NSArray *tmp = [self.titleArr allObjects];
    [self setChooseViewSubViews:tmp toView:self.chooseBack];
}
/** 换一批点击事件 */
- (void)changeLabelTitle{
    [self requestLabels];
    [UIView animateWithDuration:0.5 animations:^{
        self.addView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    }completion:^(BOOL finished) {
        [self.addView removeAllSubviews];
    }];
}
/** 创建数据源 */
- (void)setAddViewSubViews:(NSArray *)arr toView:(UIView *)addView{
    [UIView animateWithDuration:0.5 animations:^{
        self.addView.layer.transform = CATransform3DIdentity;
    }completion:^(BOOL finished) {
        CGFloat width = 15;
        CGFloat height = 20;
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dic = arr[i];
            UIButton *titleBtu = [UIButton buttonWithType:UIButtonTypeCustom];
            titleBtu.frame = CGRectMake(width,height, 100, 30);
            [titleBtu setTitle:dic[@"name"] forState:UIControlStateNormal];
            [titleBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
            titleBtu.titleLabel.font = KGFontSHRegular(13);
            titleBtu.tag = [dic[@"id"] integerValue];
            titleBtu.backgroundColor = KGWhiteColor;
            titleBtu.layer.cornerRadius = 15;
            titleBtu.layer.masksToBounds = YES;
            titleBtu.layer.borderColor = KGGrayColor.CGColor;
            titleBtu.layer.borderWidth = 1;
            [titleBtu addTarget:self action:@selector(chooseBtuTitle:) forControlEvents:UIControlEventTouchUpInside];
            [addView addSubview:titleBtu];
            if ((i+1)%3 == 0) {
                height = height + 45;
                width = 15;
            }else{
                width = width + 115;
            }
        }
    }];
}
/** 选择标签点击事件 */
- (void)chooseBtuTitle:(UIButton *)sender{
    if (self.titleArr.count < 15) {
        if ([sender.backgroundColor isEqual:KGWhiteColor]) {
            [sender setTitleColor:KGWhiteColor forState:UIControlStateNormal];
            sender.layer.borderColor = KGBlueColor.CGColor;
            sender.backgroundColor = KGBlueColor;
            [self.titleArr addObject:@{@"name":sender.currentTitle,@"id":[NSString stringWithFormat:@"%ld",(long)sender.tag]}];
        }else{
            [sender setTitleColor:KGGrayColor forState:UIControlStateNormal];
            sender.layer.borderColor = KGGrayColor.CGColor;
            sender.backgroundColor = KGWhiteColor;
            [self.titleArr removeObject:@{@"name":sender.currentTitle,@"id":[NSString stringWithFormat:@"%ld",(long)sender.tag]}];
        }
        self.countLab.text = [NSString stringWithFormat:@"%lu/15",(unsigned long)self.titleArr.count];
    }else{
        if ([sender.backgroundColor isEqual:KGBlueColor]) {
            [sender setTitleColor:KGGrayColor forState:UIControlStateNormal];
            sender.layer.borderColor = KGGrayColor.CGColor;
            sender.backgroundColor = KGWhiteColor;
            [self.titleArr removeObject:@{@"name":sender.currentTitle,@"id":[NSString stringWithFormat:@"%ld",(long)sender.tag]}];
        }
        self.countLab.text = [NSString stringWithFormat:@"%lu/15",(unsigned long)self.titleArr.count];
    }
    [self changeChooseBtuTitile];
}
/** 改变选择按钮的标题 */
- (void)changeChooseBtuTitile{
    if (self.titleArr.count > 0) {
        NSArray *tmp = [self.titleArr allObjects];
        NSDictionary *firstDic = tmp[0];
        NSString *title = firstDic[@"name"];
        for (int i = 1; i < self.titleArr.count; i++) {
            NSDictionary *dic = tmp[i];
            title = [NSString stringWithFormat:@"%@/%@",title,dic[@"name"]];
        }
        [self.chooseBtu setTitle:title forState:UIControlStateNormal];
    }else{
        [self.chooseBtu setTitle:@"" forState:UIControlStateNormal];
    }
}
/** 已选择展示view */
- (UIView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
        _chooseView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.2];
        [self.view addSubview:_chooseView];
        /** 个性标签 */
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, [self calculateWidthWithString:@"您的个性标签：" font:KGFontSHRegular(14)], 50)];
        titleLab.text = @"您的个性标签：";
        titleLab.font = KGFontSHRegular(14);
        titleLab.textColor = KGBlackColor;
        [_chooseView addSubview:titleLab];
        
        self.chooseBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 300)];
        self.chooseBack.backgroundColor = KGWhiteColor;
        [_chooseView insertSubview:self.chooseBack atIndex:0];
    }
    return _chooseView;
}
/** 监听view点击事件 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if ([touch.view isEqual:self.chooseView]) {
        self.chooseView.hidden = YES;
        [self changeChooseBtuTitile];
        self.countLab.text = [NSString stringWithFormat:@"%lu/15",(unsigned long)self.titleArr.count];
    }
}
/** 创建数据源 */
- (void)setChooseViewSubViews:(NSArray *)arr toView:(UIView *)addView{
    CGFloat width = 15;
    CGFloat height = 70;
    for (int i = 0; i < arr.count; i++) {
        UIButton *titleBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtu.frame = CGRectMake(width,height, 100, 30);
        NSDictionary *dic = arr[i];
        [titleBtu setTitle:dic[@"name"] forState:UIControlStateNormal];
        [titleBtu setTitleColor:KGWhiteColor forState:UIControlStateNormal];
        titleBtu.titleLabel.font = KGFontSHRegular(13);
        titleBtu.tag = [dic[@"id"] integerValue];
        titleBtu.backgroundColor = KGBlueColor;
        titleBtu.layer.cornerRadius = 15;
        titleBtu.layer.masksToBounds = YES;
        titleBtu.layer.borderColor = KGBlueColor.CGColor;
        titleBtu.layer.borderWidth = 1;
        [titleBtu addTarget:self action:@selector(deleteChoose:) forControlEvents:UIControlEventTouchUpInside];
        [addView addSubview:titleBtu];
        if ((i+1)%3 == 0) {
            height = height + 45;
            width = 15;
        }else{
            width = width + 115;
        }
    }
}
/** 删除已选择 */
- (void)deleteChoose:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [self.titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        if ([dic[@"id"] integerValue] == sender.tag) {
            [weakSelf.titleArr removeObject:obj];
            *stop = YES;
        }
    }];
    [self.chooseBack removeAllSubviews];
    NSArray *tmpArr = [self.titleArr allObjects];
    [self setChooseViewSubViews:tmpArr toView:self.chooseBack];
    [self.view setNeedsLayout];
    [self changeChooseBtuTitile];
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
