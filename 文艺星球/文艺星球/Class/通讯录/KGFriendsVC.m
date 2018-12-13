//
//  KGFriendsVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGFriendsVC.h"
#import "KGFriendsSystomNoticeVC.h"

@interface KGFriendsVC ()

@end

@implementation KGFriendsVC

- (id)init{
    if (self = [super init]) {
        /** 设置界面需要显示的会话类型 */
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        /** 设置界面需要那些类型的会话在会话列表中聚合显示 */
        [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                              @(ConversationType_GROUP)]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    [self setChatListViewControllerUI];
}
/** 设置聊天列表界面 */
- (void)setChatListViewControllerUI{
    /** 去掉系统默认的横线 */
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.conversationListTableView.tableFooterView = [UIView new];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    backView.backgroundColor = KGWhiteColor;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center = backView.center;
    imageView.image = [UIImage imageNamed:@"kongyemian"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backView addSubview:imageView];
    self.emptyConversationView = backView;
    self.conversationListTableView.tableHeaderView = [self setUpHeaderView];
}
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    conversationVC.hidesBottomBarWhenPushed = YES;
    UIImage *image = [UIImage new];
    [self.navigationController.navigationBar setShadowImage:image];
    [self.navigationController pushViewController:conversationVC animated:YES];
}
/** 头视图 */
- (UIView *)setUpHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 80)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
    imageView.image = [UIImage imageNamed:@"guanfangtouxiang"];
    [headerView addSubview:imageView];
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, KGScreenWidth - 90, 30)];
    nameLab.text = @"文艺星球官方";
    nameLab.textColor = KGBlueColor;
    nameLab.font = KGFontSHRegular(11);
    [headerView addSubview:nameLab];
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, KGScreenWidth - 90, 30)];
    detailLab.text = @"最可爱的官方";
    detailLab.textColor = KGGrayColor;
    detailLab.font = KGFontSHRegular(13);
    [headerView addSubview:detailLab];
    UIButton *topBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtu.frame = CGRectMake(0, 0, KGScreenWidth, 60);
    [topBtu addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:topBtu];
    UIView *lowView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, KGScreenWidth, 20)];
    lowView.backgroundColor = KGLineColor;
    [headerView addSubview:lowView];
    UILabel *msgLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, KGScreenWidth - 30, 20)];
    msgLab.text = @"全部消息";
    msgLab.textColor = KGGrayColor;
    msgLab.font = KGFontSHRegular(10);
    [lowView addSubview:msgLab];
    
    return headerView;
}
/** 点击事件 */
- (void)selectAction{
    KGFriendsSystomNoticeVC *vc = [[KGFriendsSystomNoticeVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
