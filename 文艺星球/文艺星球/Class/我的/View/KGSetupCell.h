//
//  KGSetupCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGSetupCell : UITableViewCell
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
/** 右侧打开 */
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end

NS_ASSUME_NONNULL_END
