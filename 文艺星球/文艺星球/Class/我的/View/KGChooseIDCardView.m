//
//  KGChooseIDCardView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGChooseIDCardView.h"

@interface KGChooseIDCardView ()<UIPickerViewDelegate,UIPickerViewDataSource>
/** 选择的证件类型 */
@property (nonatomic,copy) NSString *chooseType;
/** 数据源 */
@property (nonatomic,copy) NSArray *dataArr;
/** 选择器 */
@property (nonatomic,strong) UIPickerView *pickView;
/** 选择row */
@property (nonatomic,assign) NSInteger selectRow;

@end

@implementation KGChooseIDCardView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KGAlpheColor;
        self.dataArr = @[@"港澳身份证",@"二代身份证",@"台湾身份证"];
        self.selectRow = 1;
        [self setUI];
    }
    return self;
}
/** 搭建UI */
- (void)setUI{
    /** 背景view */
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenHeight - 230, KGScreenWidth, 230)];
    backView.backgroundColor = KGWhiteColor;
    [self addSubview:backView];
    /** 选择器 */
    self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, KGScreenWidth, 170)];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    [self.pickView selectRow:1 inComponent:0 animated:YES];
    [backView addSubview:self.pickView];
    /** 取消按钮 */
    UIButton *cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtu.frame = CGRectMake(15, 0, 100, 30);
    [cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    cancelBtu.titleLabel.font = KGFontSHRegular(12);
    cancelBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancelBtu addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtu];
    /** 确认按钮 */
    UIButton *shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    shureBtu.frame = CGRectMake(KGScreenWidth - 115, 0, 100, 30);
    [shureBtu setTitle:@"确定" forState:UIControlStateNormal];
    [shureBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    shureBtu.titleLabel.font = KGFontSHRegular(12);
    shureBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [shureBtu addTarget:self action:@selector(shureAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:shureBtu];
}
/** 取消按钮点击事件 */
- (void)cancelAction{
    self.hidden = YES;
}
/** 确认按钮点击事件 */
- (void)shureAction{
    if (self.chooseIdCardClass) {
        self.chooseIdCardClass(self.dataArr[self.selectRow]);
    }
    self.hidden = YES;
}
/** UIPickerViewDelegate */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *titleLab = nil;
    if (!titleLab) {
        titleLab = [[UILabel alloc]init];
        titleLab.textColor = KGGrayColor;
        titleLab.font = KGFontSHRegular(13);
        titleLab.text = self.dataArr[row];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.backgroundColor = [UIColor clearColor];
    }
    if (row == self.selectRow) {
        titleLab.textColor = KGBlueColor;
    }
    return titleLab;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArr[row];
}
/** UIPickerViewDataSource */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 3;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectRow = row;
    [self.pickView reloadAllComponents];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
