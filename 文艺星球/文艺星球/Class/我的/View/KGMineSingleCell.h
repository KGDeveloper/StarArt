//
//  KGMineSingleCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGMineSingleCellDelegate <NSObject>
/** 点击事件 */
- (void)selectViewWithTitile:(NSString *)title;

@end

@interface KGMineSingleCell : UITableViewCell
/** 参数 */
@property (nonatomic,copy) NSDictionary *infoDic;
/** 代理点击事件 */
@property (nonatomic,weak) id<KGMineSingleCellDelegate>delegate;

@end

