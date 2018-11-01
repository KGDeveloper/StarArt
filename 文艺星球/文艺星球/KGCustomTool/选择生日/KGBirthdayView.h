//
//  KGBirthdayView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/23.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGBirthdayView : UIView
/** 选择后的生日以及星座 */
@property (nonatomic,copy) void(^chooseBirthdayString)(NSString *birthday,NSString *constellation);

@end

NS_ASSUME_NONNULL_END
