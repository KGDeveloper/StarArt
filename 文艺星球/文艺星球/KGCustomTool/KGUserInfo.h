//
//  KGUserInfo.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGUserInfo : NSObject
/** 初始化 */
+ (instancetype)shareInstance;
/** 用户名 */
- (NSString *)userName;
/** 手机号 */
- (NSString *)userPhone;
/** 签名 */
- (NSString *)userSignature;
/** 头像 */
- (NSString *)userPortrait;
/** 年龄 */
- (NSString *)userAge;
/** 性别 */
- (NSString *)userSex;
/** 用户id */
- (NSString *)userId;
/** 获取版本号 */
- (NSString *)app_Version;
/** 融云token */
- (NSString *)rongIMToken;
/** 个人封面 */
- (NSString *)userCoverImage;
/** token */
- (NSString *)userToken;
/** 签名 */
- (NSString *)userPersonalitySignature;
/** 持久化个人信息 */
+ (void)saveUserInfoWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
