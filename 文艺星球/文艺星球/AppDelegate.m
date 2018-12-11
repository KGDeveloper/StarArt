//
//  AppDelegate.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/9/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "AppDelegate.h"
#import "KGLoginVC.h"
#import "KGTabbarVC.h"

@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    if ([KGUserInfo shareInstance].userToken) {
        self.window.rootViewController = [[KGTabbarVC alloc]init];
    }else{
        self.window.rootViewController = [[KGLoginVC alloc]init];
    }
    [self.window makeKeyAndVisible];
    [self registGeodo];
    [self registRongIM];
    return YES;
}

/** 注册高德地图 */
- (void)registGeodo{
    [AMapServices sharedServices].apiKey = @"5a8e15e6edaf329a1716b6ab48a5f266";
    [AMapServices sharedServices].enableHTTPS = YES;
}
/** 注册融云 */
- (void)registRongIM{
    [[RCIM sharedRCIM] initWithAppKey:@"qd46yzrfqimtf"];
    if ([[KGUserInfo shareInstance] rongIMToken]) {
        [[RCIM sharedRCIM] connectWithToken:[KGUserInfo shareInstance].rongIMToken success:^(NSString *userId) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [RCIM sharedRCIM].userInfoDataSource = self;
                [RCIM sharedRCIM].groupInfoDataSource = self;
                [RCIM sharedRCIM].enableMessageRecall = YES;
                [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
                [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
            });
        } error:^(RCConnectErrorCode status) {
            
        } tokenIncorrect:^{
            
        }];
    }
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    if ([userId isEqualToString:[KGUserInfo shareInstance].userToken]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc]init];
        userInfo.userId = userId;
        userInfo.name = [KGUserInfo shareInstance].userName;
        userInfo.portraitUri = [KGUserInfo shareInstance].userPortrait;
        return completion(userInfo);
    }else{
        [KGRequest postWithUrl:[RequestUserInfo stringByAppendingString:[NSString stringWithFormat:@"/%@",[KGUserInfo shareInstance].userId]] parameters:@{} succ:^(id  _Nonnull result) {
            if ([result[@"status"] integerValue] == 200) {
                NSDictionary *dic = result[@"data"];
                RCUserInfo *userInfo = [[RCUserInfo alloc]init];
                userInfo.userId = userId;
                userInfo.name = dic[@"username"];
                userInfo.portraitUri = dic[@"portraitUri"];
                [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userId];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMessageUI" object:nil];
            }
        } fail:^(NSError * _Nonnull error) {
            
        }];
        RCUserInfo *info = [[RCIM sharedRCIM] getUserInfoCache:userId];
        return completion(info);
    }
}
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([KGUserInfo shareInstance].userToken) {
        [KGRequest postWithUrl:FindRefreshPage parameters:@{} succ:^(id  _Nonnull result) {
            
        } fail:^(NSError * _Nonnull error) {
            
        }];
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
