//
//  KGSquareMessageCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGSquareMessageCell : UITableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contextLab;
/** 消息图片 */
@property (weak, nonatomic) IBOutlet UIImageView *customImage;


@end

NS_ASSUME_NONNULL_END
