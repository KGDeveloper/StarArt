//
//  KGBirthdayView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/23.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBirthdayView.h"

@interface KGBirthdayView ()
/** 日期选择器 */
@property (nonatomic,strong) UIDatePicker *datePick;
/** 取消 */
@property (nonatomic,strong) UIButton *cancelBtu;
/** 确定 */
@property (nonatomic,strong) UIButton *shureBtu;
/** 当前时间 */
@property (nonatomic,copy) NSString *currDate;

@end

@implementation KGBirthdayView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KGWhiteColor;
        [self setUI];
    }
    return self;
}
/** 搭建界面 */
- (void)setUI{
    /** 日期选择器 */
    self.datePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(40, 10, KGViewWidth(self) - 80, KGViewHeight(self) - 30)];
    self.datePick.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.datePick.datePickerMode = UIDatePickerModeDate;
    self.datePick.tintColor = [UIColor redColor];
    [self.datePick setDate:[NSDate date] animated:YES];
    [self.datePick addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.datePick];
    /** 顶部直线 */
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGViewWidth(self), 1)];
    line.backgroundColor = KGGrayColor;
    [self addSubview:line];
    /** 取消按钮 */
    self.cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtu.frame = CGRectMake(15, 1, 40, 32);
    [self.cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    self.cancelBtu.titleLabel.font = KGFontSHRegular(12);
    self.cancelBtu.contentMode = UIControlContentHorizontalAlignmentLeft;
    [self.cancelBtu addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtu];
    /** 确定按钮 */
    self.shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shureBtu.frame = CGRectMake(KGViewWidth(self) - 55, 1, 40, 32);
    [self.shureBtu setTitle:@"确定" forState:UIControlStateNormal];
    [self.shureBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.shureBtu.titleLabel.font = KGFontSHRegular(12);
    self.shureBtu.contentMode = UIControlContentHorizontalAlignmentRight;
    [self.shureBtu addTarget:self action:@selector(shureAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shureBtu];
}
/** 选择日期 */
- (void)dateChange:(UIDatePicker *)sender{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    self.currDate = [formatter stringFromDate:sender.date];
}
/** 取消事件 */
- (void)cancelAction{
    self.hidden = YES;
}
/** 确认事件 */
- (void)shureAction{
    if (self.currDate.length > 0) {
        if (self.chooseBirthdayString) {
            NSString *month = [[[[self.currDate componentsSeparatedByString:@"年"] lastObject] componentsSeparatedByString:@"月"] firstObject];
            NSString *day = [[[[self.currDate componentsSeparatedByString:@"年"] lastObject] componentsSeparatedByString:@"月"] lastObject];
            self.chooseBirthdayString(self.currDate, [self determineTheconstellationWithMonth:month.integerValue day:day.integerValue]);
        }
        self.hidden = YES;
    }else{
        [[KGHUD showMessage:@"请选择正确时间"] hideAnimated:YES afterDelay:1];
    }
}
/** 根据日期判断星座 */
- (NSString *)determineTheconstellationWithMonth:(NSInteger)month day:(NSInteger)day{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (month<1||month>12||day<1||day>31){
        return @"错误日期格式!";
    }
    if(month==2 && day>29){
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    result = [NSString stringWithFormat:@"%@座",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
