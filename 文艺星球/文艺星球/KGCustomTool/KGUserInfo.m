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
    return [[NSUserDefaults standardUserDefaults] objectForKey:@""];
}
/** 手机号 */
- (NSString *)userPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@""];
}
/** 签名 */
- (NSString *)userSignature{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@""];
}
/** 头像 */
- (NSString *)userPortrait{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@""];
}
/** 年龄 */
- (NSString *)userAge{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@""];
}
/** 性别 */
- (NSString *)userSex{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@""];
}
/** 用户id */
- (NSString *)userId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@""];
}
/** 获取版本号 */
- (NSString *)app_Version{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

@end
