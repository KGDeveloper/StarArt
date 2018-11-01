//
//  KGChooseIDCardView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KGChooseIDCardView : UIView
/** 选择类型 */
@property (nonatomic,copy) void(^chooseIdCardClass)(NSString *className);

@end

