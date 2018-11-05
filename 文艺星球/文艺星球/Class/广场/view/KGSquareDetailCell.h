//
//  KGSquareDetailCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGSquareDetailCell : UITableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contextLab;

@end

NS_ASSUME_NONNULL_END
