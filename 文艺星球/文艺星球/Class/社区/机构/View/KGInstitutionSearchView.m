//
//  KGInstitutionSearchView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGInstitutionSearchView.h"

@interface KGInstitutionSearchView ()<UITextFieldDelegate>

@end

@implementation KGInstitutionSearchView

- (instancetype)shareInstanceWithType:(NSString *)type{
    self.type = type;
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"KGInstitutionSearchView" owner:self options:nil];
        self.customView.frame = self.bounds;
        [self addSubview:self.customView];
        self.topHeight.constant = [[UIApplication sharedApplication] statusBarFrame].size.height + 10;
        self.searchTF.delegate = self;
        [self requestData];
    }
    return self;
}
- (IBAction)returnAction:(UIButton *)sender {
    self.hidden = YES;
}
- (IBAction)clearAction:(UIButton *)sender {
    [KGRequest postWithUrl:DeleteCommunitySearchByUid parameters:@{@"navigation":self.type,@"uid":[KGUserInfo shareInstance].userId} succ:^(id  _Nonnull result) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}
/** 请求历史记录 */
- (void)requestData{
    [KGRequest postWithUrl:SelectCommunitySearchByUid parameters:@{@"navigation":self.type,@"uid":[KGUserInfo shareInstance].userId} succ:^(id  _Nonnull result) {
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
