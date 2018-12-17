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
/** 普通场所详情查看评论 */
#define SelectCommunityPlaceCommentByMid [POSTURL stringByAppendingString:@"/api/merchants/selectCommunityPlaceCommentByMid"]
/** 普通场所详情添加评论 */
#define AddCommunityPlaceCommentByMid [POSTURL stringByAppendingString:@"/api/merchants/addCommunityPlaceCommentByMid"]
/** 查询机构列表 */
#define SelectCommunityPlaceList [POSTURL stringByAppendingString:@"/api/merchants/selectCommunityPlaceList"]
/** 对机构评论点赞 */
#define UpPlaceCommentLikeStatusByCid [POSTURL stringByAppendingString:@"/api/merchants/upPlaceCommentLikeStatusByCid"]
/** 根据id查询展览详情 */
#define SelectExhibitionByEID [POSTURL stringByAppendingString:@"/api/aCommunityExhibition/selectExhibitionByEID"]
/** 根据城市id查询城市二级区域 */
#define FindAllMerchantCity [POSTURL stringByAppendingString:@"/api/merchantCity/findAllMerchantCity"]
/** 查询5条广告 */
#define SelectEightFood [POSTURL stringByAppendingString:@"/api/merchants/selectEightFood"]
/** 查询搜索记录 */
#define SelectCommunitySearchByUid [POSTURL stringByAppendingString:@"/api/communitysearch/selectCommunitySearchByUid"]
/** 清空搜索记录 */
#define DeleteCommunitySearchByUid [POSTURL stringByAppendingString:@"/api/communitysearch/deleteCommunitySearchByUid"]
/** 戏剧热门5条 */
#define SelectShowListFives [POSTURL stringByAppendingString:@"/api/aCommunityShow/selectShowListFives"]
/** 戏剧列表查询 */
#define SelectShowList [POSTURL stringByAppendingString:@"/api/aCommunityShow/selectShowList"]
/** 戏剧详情查询 */
#define SelectShowBySID [POSTURL stringByAppendingString:@"/api/aCommunityShow/selectShowBySID"]
/** 展览列表查询 */
#define SelectExhibitionList [POSTURL stringByAppendingString:@"/api/aCommunityExhibition/selectExhibitionList"]
/** 展览顶部5条查询 */
#define SelectExhibitionListFives [POSTURL stringByAppendingString:@"/api/aCommunityExhibition/selectExhibitionListFives"]
/** 交友查询 */
#define SelectUserLabelSame [POSTURL stringByAppendingString:@"/api/user/selectUserLabelSame"]
/** 书籍首页 */
#define SelectBookList [POSTURL stringByAppendingString:@"/api/aCommunityBook/selectBookList"]
/** 书籍查看更多 */
#define SelectBookListMore [POSTURL stringByAppendingString:@"/api/aCommunityBook/selectBookListMore"]
/** 书籍根据id查看详情 */
#define SelectBookByID [POSTURL stringByAppendingString:@"/api/aCommunityBook/selectBookByID"]
/** 书籍评论点赞 */
#define AddCommentLikeStatusByCid [POSTURL stringByAppendingString:@"/api/aCommunityBook/addCommentLikeStatusByCid"]
/** 书籍添加评论 */
#define AddCommentByCidAndUid [POSTURL stringByAppendingString:@"/api/aCommunityBook/addCommentByCidAndUid"]
/** 书籍查看评论 */
#define SelectBookCommetnByCid [POSTURL stringByAppendingString:@"/api/aCommunityBook/selectBookCommetnByCid"]
/** 新闻列表 */
#define SelectNewsList [POSTURL stringByAppendingString:@"/api/communityNews/selectNewsList"]
/** 新闻头部列表 */
#define SelectNewsListFives [POSTURL stringByAppendingString:@"/api/communityNews/selectNewsListFives"]
/** 新闻点赞 */
#define AddNewsLikeStatusByUid [POSTURL stringByAppendingString:@"/api/communityNews/addNewsLikeStatusByUid"]
/** 新闻详情 */
#define SelectNewsByNid [POSTURL stringByAppendingString:@"/api/communityNews/selectNewsByNid"]
/** 查看新闻评论 */
#define SelectNewsCommentListByNid [POSTURL stringByAppendingString:@"/api/communityNews/selectNewsCommentListByNid"]
/** 添加新闻评论 */
#define AddNewsCommentByNid [POSTURL stringByAppendingString:@"/api/communityNews/addNewsCommentByNid"]
/** 添加收藏 */
#define AddPersonCollect [POSTURL stringByAppendingString:@"/api/personCollect/add"]
/** 新闻举报 */
#define AddNewsReportByNid [POSTURL stringByAppendingString:@"/api/communityNews/addNewsReportByNid"]
/** 艺术家列表 */
#define selectArtistList [POSTURL stringByAppendingString:@"/api/communityArtist/selectArtistList"]
/** 用户举报 */
#define SaveUserReport [POSTURL stringByAppendingString:@"/api/report/saveUserReport"]
/** 用户关注 */
#define Attorcel [POSTURL stringByAppendingString:@"/api/associated/attorcel"]





/** 文化场所首页 */
#define FindAllMerchant [POSTURL stringByAppendingString:@"/api/merchants/findAllMerchant"]
/** 文化场所筛选 */
#define FindTypeAllMerchant [POSTURL stringByAppendingString:@"/api/merchants/findTypeAllMerchant"]
/** 文艺消费首页 */
#define FindAllConsumeMerchant [POSTURL stringByAppendingString:@"/api/consumption/findAllConsumeMerchant"]
/** 文艺消费筛选 */
#define FindTypeConsumeMerchant [POSTURL stringByAppendingString:@"/api/consumption/findTypeConsumeMerchant"]


#endif /* KGRequestHeader_h */
