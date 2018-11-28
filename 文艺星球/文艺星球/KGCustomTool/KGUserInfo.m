//
//  KGUserInfo.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGUserInfo.h"

static KGUserInfo *userInfo;

@implementation KGUserInfo

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[KGUserInfo alloc]init];
    });
    return userInfo;
}
/** 用户名 */
- (NSString *)userName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}
/** 手机号 */
- (NSString *)userPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"telephone"];
}
/** 签名 */
- (NSString *)userSignature{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"personalitySignature"];
}
/** 头像 */
- (NSString *)userPortrait{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"portraitUri"];
}
/** 年龄 */
- (NSString *)userAge{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userAge"];
}
/** 性别 */
- (NSString *)userSex{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userSex"];
}
/** 用户id */
- (NSString *)userId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
}
/** 获取版本号 */
- (NSString *)app_Version{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}
/** 融云rtoken */
- (NSString *)rongIMToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"RongToken"];
}
/** 个人封面 */
- (NSString *)userCoverImage{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userCoverImage"];
}
/** token */
- (NSString *)userToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}
/** 签名 */
- (NSString *)userPersonalitySignature{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"personalitySignature"];
}
/** 持久化个人信息 */
+ (void)saveUserInfoWithDictionary:(NSDictionary *)dic{
    if (dic[@"accessToken"]) {
        [[NSUserDefaults standardUserDefaults] setObject:dic[@"accessToken"] forKey:@"RongToken"];
    }
    if (dic[@"coverImage"]) {
        [[NSUserDefaults standardUserDefaults] setObject:dic[@"coverImage"] forKey:@"userCoverImage"];
    }
    if (dic[@"id"]) {
        [[NSUserDefaults standardUserDefaults] setObject:dic[@"id"] forKey:@"userId"];
    }
    if (dic[@"portraitUri"]) {
        [[NSUserDefaults standardUserDefaults] setObject:dic[@"portraitUri"] forKey:@"portraitUri"];
    }
    if (dic[@"telephone"]) {
        [[NSUserDefaults standardUserDefaults] setObject:dic[@"telephone"] forKey:@"telephone"];
    }
    if (dic[@"username"]) {
        [[NSUserDefaults standardUserDefaults] setObject:dic[@"username"] forKey:@"username"];
    }
    if (dic[@"birthday"]) {
        if (![dic[@"birthday"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"birthday"] forKey:@"userBirthday"];
        }
    }
    if (dic[@"personalitySignature"]) {
        if (![dic[@"personalitySignature"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"personalitySignature"] forKey:@"personalitySignature"];
        }
    }
    if (dic[@"sex"]) {
        if (![dic[@"sex"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"sex"] forKey:@"userSex"];
        }
    }
    if (dic[@"age"]) {
        if (![dic[@"age"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"age"] forKey:@"userAge"];
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
