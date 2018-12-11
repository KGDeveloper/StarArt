//
//  KGFriendsVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGFriendsVC.h"

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
