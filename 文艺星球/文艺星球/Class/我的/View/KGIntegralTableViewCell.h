//
//  KGIntegralTableViewCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGIntegralTableViewCell : UITableViewCell
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 积分 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;

@end

