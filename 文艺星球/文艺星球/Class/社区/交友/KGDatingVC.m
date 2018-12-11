//
//  KGDatingVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGDatingVC.h"
#import "KGDatingView.h"
#import "KGDatingManagerVC.h"
#import "KGChatVC.h"

@interface KGDatingVC ()

@property (nonatomic,strong) NSMutableArray *firendsArr;

@end

@implementation KGDatingVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    
    self.view.backgroundColor = KGWhiteColor;
    self.title = @"交友";
    self.firendsArr = [NSMutableArray array];
    [self requestData];
}
/** 请求数据 */
- (void)requestData{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:SelectUserLabelSame parameters:@{} succ:^(id  _Nonnull result) {
        [hud hideAnimated:YES];
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.firendsArr addObjectsFromArray:tmp];
            }
            [weakSelf setDatingView];
        }
    } fail:^(NSError * _Nonnull error) {
        [hud hideAnimated:YES];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建聊天 */
- (void)setDatingView{
    __weak typeof(self) weakSelf = self;
    if (self.firendsArr.count > 0) {
        for (int i = 0; i < self.firendsArr.count; i++) {
            KGDatingView *datingView = [[KGDatingView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
            NSDictionary *dic = self.firendsArr[i];
            datingView.userInfo = dic;
            datingView.leftMoveRemoveSelf = ^{
                [weakSelf.firendsArr removeFirstObject];
                if (weakSelf.firendsArr.count == 0) {
                    [weakSelf requestData];
                }
            };
            datingView.rightMoveStarChat = ^(NSString *userID) {
                KGChatVC *vc = [[KGChatVC alloc]init];
                vc.userID = userID;
                vc.conversationType = ConversationType_PRIVATE;
                vc.targetId = userID;
                __block NSString *nameStr = nil;
                [weakSelf.firendsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic = obj;
                    if ([dic[@"id"] integerValue] == [userID integerValue]) {
                        nameStr = dic[@"username"];
                        *stop = YES;
                    }
                }];
                vc.title = nameStr;
                [weakSelf pushHideenTabbarViewController:vc animted:YES];
            };
            [self.view addSubview:datingView];
        }
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
