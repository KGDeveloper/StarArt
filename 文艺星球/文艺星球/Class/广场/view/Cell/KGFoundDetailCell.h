//
//  KGFoundDetailCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGFoundDetailCell : UITableViewCell
/** 计算高度 */
- (CGFloat)returnCellHeightWithDic:(NSDictionary *)dic;
/** 填充 */
- (void)cellWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
