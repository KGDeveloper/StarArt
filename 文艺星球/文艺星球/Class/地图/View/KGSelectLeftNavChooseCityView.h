//
//  KGSelectLeftNavChooseCityView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGSelectLeftNavChooseCityView : UIView

@property (nonatomic,copy) void(^chooseResult)(NSString *result,NSString *cityId);

@end

NS_ASSUME_NONNULL_END
