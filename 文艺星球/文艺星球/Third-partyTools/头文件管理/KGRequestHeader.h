//
//  KGRequestHeader.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#ifndef KGRequestHeader_h
#define KGRequestHeader_h

#define POSTURL @"http://192.168.1.119"
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
#define UserLabelsSame [POSTURL stringByAppendingString:@"/api/user/selectUserLabelSame"]

#endif /* KGRequestHeader_h */
