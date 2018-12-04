//
//  KGRequestHeader.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#ifndef KGRequestHeader_h
#define KGRequestHeader_h
/** 线上 */
//#define POSTURL @"http://iartplanet.com"
/** zhai */
#define POSTURL @"http://192.168.1.119"
/** zhang */
//#define POSTURL @"http://192.168.1.6"
/** 登录发送验证码 */
#define LoginSMS [POSTURL stringByAppendingString:@"/api/sendMsg"]
/** 登录验证 */
#define Login [POSTURL stringByAppendingString:@"/api/login"]
/** 注册 */
#define Register [POSTURL stringByAppendingString:@"/api/register"]
/** 查看个人资料 */
#define RequestUserInfo [POSTURL stringByAppendingString:@"/api/user"]
/** 编辑个人资料 */
#define UpdateUserInfo [POSTURL stringByAppendingString:@"/api/user/update"]
/** 生成七牛云token */
#define QiNiuToken [POSTURL stringByAppendingString:@"/api/userIntegral/findQiNiuYuntoken"]
/** 个人标签 */
#define RandomLabel [POSTURL stringByAppendingString:@"/api/mylabel/random"]
/** 积分详情 */
#define FindIntegerDetails [POSTURL stringByAppendingString:@"/api/userIntegral/findIntegerDetails"]
/** 刷新登录时间 */
#define FindRefreshPage [POSTURL stringByAppendingString:@"/api/userIntegral/findRefreshPage"]
/** 积分首页数据 */
#define FindIntegerHomePage [POSTURL stringByAppendingString:@"/api/userIntegral/findIntegerHomePage"]
/** 查询收藏 */
#define CollectionList [POSTURL stringByAppendingString:@"/api/personCollect/list"]
/** 达人认证 */
#define SAVEAlert [POSTURL stringByAppendingString:@"/api/userAuthentication/saveuserAuthentication"]
/** 意见反馈 */
#define SaveUserOpinion [POSTURL stringByAppendingString:@"/api/userOpinion/saveUserOpinion"]
/** 删除收藏 */
#define DeleteCollectionList [POSTURL stringByAppendingString:@"/api/personCollect/delete"]
/** 查询收藏 */
#define ListMessage [POSTURL stringByAppendingString:@"/api/releaseFriendMessage/listMessage"]








/** 发布广场 */
#define ReleaseFriends [POSTURL stringByAppendingString:@"/api/releaseFriendMessage/addMessage"]
/** 广场列表 */
#define ReleaseFriendsListMessage [POSTURL stringByAppendingString:@"/api/releaseFriendMessage/listMessage"]
/** 广场列表详情 */
#define ReleaseFriendsGetMessageDetail [POSTURL stringByAppendingString:@"/api/releaseFriendMessage/getMessageDetail"]
/** 点赞/取消点赞 */
#define addLike [POSTURL stringByAppendingString:@"/api/like/addLike"]
/** 未读消息 */
#define UnreadInform [POSTURL stringByAppendingString:@"/api/inform/unreadInform"]
/** 查看历史消息 */
#define ListInform [POSTURL stringByAppendingString:@"/api/inform/listInform"]
/** 发布评论 */
#define AddComment [POSTURL stringByAppendingString:@"/api/releaseFriendComment/addComment"]
/** 清空通知列表 */
#define DeleteInform [POSTURL stringByAppendingString:@"/api/inform/deleteInform"]
/** 发布好去处 */
#define SaveGoodPlace [POSTURL stringByAppendingString:@"/api/goodPlace/saveGoodPlace"]
/** 发现好去处 */
#define FindAllGoodPlace [POSTURL stringByAppendingString:@"/api/goodPlace/findConditionGoodPlace"]
/** 发现好去处详情 */
#define FindGoodPlaceById [POSTURL stringByAppendingString:@"/api/goodPlace/findGoodPlaceById"]
/** 发现好去处的点赞取消点赞 */
#define SaveUserGoodPlaceCommentLikeStuts [POSTURL stringByAppendingString:@"/api/goodplacecommentuser/saveUserGoodPlaceCommentLikeStuts"]
/** 发现好去处的评论 */
#define SaveGoodPlaceComment [POSTURL stringByAppendingString:@"/api/goodplacecomment/saveGoodPlaceComment"]






/** 社区场所首页 */
#define SelectCommunityPlaceHome [POSTURL stringByAppendingString:@"/api/merchants/selectCommunityPlaceHome"]
/** 普通场所详情 */
#define SelectCommunityPlaceByID [POSTURL stringByAppendingString:@"/api/merchants/selectCommunityPlaceByID"]















#endif /* KGRequestHeader_h */
