//
//  KGDatingView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 交友界面 */
@interface KGDatingView : UIView
/** 用户信息 */
@property (nonatomic,strong) NSDictionary *userInfo;
/** 左滑移除 */
@property (nonatomic,copy) void(^leftMoveRemoveSelf)(void);
/** 右滑开始聊天 */
@property (nonatomic,copy) void(^rightMoveStarChat)(NSString *userID);

@end

