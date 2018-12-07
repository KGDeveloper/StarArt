//
//  KGInstitutionSearchView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionSearchView.h"

@interface KGInstitutionSearchView ()<UITextFieldDelegate>

@property (strong, nonatomic) UIButton *returnBtu;
@property (strong, nonatomic) UITextField *searchTF;
@property (strong, nonatomic) UIView *hoistryView;
@property (nonatomic,strong) UILabel *leftLab;
@property (nonatomic,strong) UIButton *clearBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KGInstitutionSearchView

- (instancetype)shareInstanceWithType:(NSString *)type{
    self.type = type;
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.backgroundColor = KGWhiteColor;
        [self createUI];
        [self requestData];
    }
    return self;
}
/** 创建UI */
- (void)createUI{
    self.returnBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchTF = [UITextField new];
    self.hoistryView = [UIView new];
    self.line = [UIView new];
    self.leftLab = [UILabel new];
    self.clearBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self sd_addSubviews:@[self.returnBtu,self.searchTF,self.hoistryView,self.line,self.leftLab,self.clearBtu]];
    
    [self.returnBtu setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    self.returnBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.returnBtu addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.returnBtu.sd_layout
    .leftSpaceToView(self, 15)
    .topSpaceToView(self, [UIApplication sharedApplication].statusBarFrame.size.height + 10)
    .widthIs(50)
    .heightIs(30);
    
    self.searchTF.placeholder = @"搜索...";
    self.searchTF.font = KGFontSHRegular(13);
    self.searchTF.textColor = KGBlackColor;
    self.searchTF.textAlignment = NSTextAlignmentCenter;
    self.searchTF.delegate = self;
    self.searchTF.layer.cornerRadius = 15;
    self.searchTF.layer.masksToBounds = YES;
    self.searchTF.backgroundColor = [KGLineColor colorWithAlphaComponent:0.6];
    self.searchTF.returnKeyType = UIReturnKeySearch;
    self.searchTF.sd_layout
    .leftSpaceToView(self.returnBtu, 15)
    .rightSpaceToView(self, 30)
    .centerYEqualToView(self.returnBtu)
    .heightIs(30);
    
    self.line.backgroundColor = KGLineColor;
    self.line.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self.returnBtu, 10)
    .heightIs(1);
    
    self.leftLab.text = @"历史记录";
    self.leftLab.textColor = KGBlackColor;
    self.leftLab.font = KGFontSHBold(13);
    self.leftLab.sd_layout
    .leftSpaceToView(self, 15)
    .topSpaceToView(self.line, 20)
    .widthIs(70)
    .heightIs(13);
    
    [self.clearBtu setImage:[UIImage imageNamed:@"qingkong"] forState:UIControlStateNormal];
    [self.clearBtu setTitle:@"清空" forState:UIControlStateNormal];
    [self.clearBtu setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    self.clearBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.clearBtu.titleLabel.font = KGFontSHRegular(13);
    self.clearBtu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self.clearBtu addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtu.sd_layout
    .rightSpaceToView(self, 15)
    .centerYEqualToView(self.leftLab)
    .widthIs(70)
    .heightIs(30);
    
    self.hoistryView.sd_layout
    .leftSpaceToView(self, 0)
    .rightEqualToView(self)
    .topSpaceToView(self.clearBtu, 15)
    .bottomEqualToView(self);
    
}
- (void)returnAction:(UIButton *)sender {
    self.hidden = YES;
}
- (void)clearAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:DeleteCommunitySearchByUid parameters:@{@"navigation":self.type,@"uid":[KGUserInfo shareInstance].userId} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            weakSelf.dataArr = [NSMutableArray array];
            [weakSelf createBtuWithArr:weakSelf.dataArr];
            [[KGHUD showMessage:@"清空成功"] hideAnimated:YES afterDelay:1];
        }else{
            [[KGHUD showMessage:@"清空失败"] hideAnimated:YES afterDelay:1];
        }
    } fail:^(NSError * _Nonnull error) {
        [[KGHUD showMessage:@"清空失败"] hideAnimated:YES afterDelay:1];
    }];
}
/** 请求历史记录 */
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    self.dataArr = [NSMutableArray array];
    [KGRequest postWithUrl:SelectCommunitySearchByUid parameters:@{@"navigation":self.type,@"uid":[KGUserInfo shareInstance].userId} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            [weakSelf.dataArr addObjectsFromArray:tmp];
            [weakSelf createBtuWithArr:weakSelf.dataArr];
        }
    } fail:^(NSError * _Nonnull error) {
        
    }];
}
/** 开始请求 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        if (self.sendSearchResult) {
            self.sendSearchResult(textField.text);
        }
        [textField resignFirstResponder];
        self.hidden = YES;
        return YES;
    }else{
        [[KGHUD showMessage:@"请输入搜索内容"] hideAnimated:YES afterDelay:1];
        return YES;
    }
}
/** 根据数组创建按钮 */
- (void)createBtuWithArr:(NSArray *)arr{
    [self.hoistryView removeAllSubviews];
    if (arr.count > 0) {
        CGFloat width = 15;
        CGFloat height = 0;
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dic = arr[i];
            CGFloat strWidth = [dic[@"content"] boundingRectWithSize:CGSizeMake(KGScreenWidth - 30, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontSHRegular(11)} context:nil].size.width + 30;
            UIButton *tmpBtu = [UIButton buttonWithType:UIButtonTypeCustom];
            tmpBtu.frame = CGRectMake(width, height, strWidth, 30);
            [tmpBtu setTitle:dic[@"content"] forState:UIControlStateNormal];
            [tmpBtu setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            tmpBtu.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
            tmpBtu.titleLabel.font = KGFontSHRegular(11);
            tmpBtu.layer.cornerRadius = 15;
            tmpBtu.layer.masksToBounds = YES;
            [tmpBtu addTarget:self action:@selector(hositaryAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.hoistryView addSubview:tmpBtu];
            if (strWidth + width > KGScreenWidth - 30) {
                width = 15;
                height += 45;
            }else{
                width += strWidth + 15;
            }
        }
    }
}
/** 历史记录点击事件 */
- (void)hositaryAction:(UIButton *)sender{
    if (self.sendSearchResult) {
        self.sendSearchResult(sender.currentTitle);
    }
    self.hidden = YES;
}
- (void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    if (hidden == NO) {
        [self requestData];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
