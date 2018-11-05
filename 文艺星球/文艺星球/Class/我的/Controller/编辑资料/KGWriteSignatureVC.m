//
//  KGWriteSignatureVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGWriteSignatureVC.h"

@interface KGWriteSignatureVC ()<YYTextViewDelegate>
/** 个性签名 */
@property (nonatomic,strong) YYTextView *signatureTV;
/** 字数统计 */
@property (nonatomic,strong) YYLabel *countLab;

@end

@implementation KGWriteSignatureVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGGrayColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"个性签名";
    self.view.backgroundColor = KGWhiteColor;
    self.rightNavItem.userInteractionEnabled = NO;
    
    [self setUI];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.sendSignature) {
        self.sendSignature(self.signatureTV.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** 搭建界面 */
- (void)setUI{
    self.signatureTV = [[YYTextView alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight + 25, KGScreenWidth - 30, 100)];
    self.signatureTV.placeholderFont = KGFontSHRegular(13);
    self.signatureTV.placeholderText = @"填写个性签名";
    self.signatureTV.placeholderTextColor = [UIColor colorWithHexString:@"#cccccc"];
    self.signatureTV.textColor = KGBlackColor;
    self.signatureTV.font = KGFontSHRegular(13);
    self.signatureTV.delegate = self;
    self.signatureTV.layer.cornerRadius = 5;
    self.signatureTV.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    self.signatureTV.layer.borderWidth = 1;
    self.signatureTV.layer.masksToBounds = YES;
    [self.view addSubview:self.signatureTV];
    
    self.countLab = [[YYLabel alloc]initWithFrame:CGRectMake(25, KGRectNavAndStatusHight + 100, KGScreenWidth - 50, 11)];
    self.countLab.textColor = KGGrayColor;
    self.countLab.font = KGFontSHRegular(11);
    self.countLab.textAlignment = NSTextAlignmentRight;
    self.countLab.attributedText = [self attributedStringWithString:@"0/28" changeString:@"0"];
    [self.view addSubview:self.countLab];
}
/** 富文本修改样式 */
- (NSMutableAttributedString *)attributedStringWithString:(NSString *)string changeString:(NSString *)changeString{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    attributedString.font = KGFontSHRegular(11);
    attributedString.alignment = NSTextAlignmentRight;
    attributedString.color = KGGrayColor;
    [attributedString setColor:KGBlackColor range:[string rangeOfString:changeString]];
    return attributedString;
}
/** YYTextViewDelegate */
- (void)textViewDidChange:(YYTextView *)textView{
    self.countLab.attributedText = [self attributedStringWithString:[NSString stringWithFormat:@"%lu/28",(unsigned long)textView.text.length] changeString:[NSString stringWithFormat:@"%lu",(unsigned long)textView.text.length]];
    if (textView.text.length > 0) {
        if (textView.text.length > 28){
            self.rightNavItem.userInteractionEnabled = NO;
            [self.rightNavItem setTitleColor:KGGrayColor forState:UIControlStateNormal];
        }else{
            self.rightNavItem.userInteractionEnabled = YES;
            [self.rightNavItem setTitleColor:KGBlueColor forState:UIControlStateNormal];
        }
    }
}
/** 监听键盘 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.signatureTV.text.length > 28) {
        [[KGHUD showMessage:@"字数超出限制！" toView:self.view] hideAnimated:YES afterDelay:1];
    }else{
        [self.signatureTV resignFirstResponder];
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
