//
//  KGSqureCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGSqureCell : UITableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *customImage;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
/** 编辑 */
@property (weak, nonatomic) IBOutlet UIView *editView;
/** 选择 */
@property (weak, nonatomic) IBOutlet UIButton *chooseBtu;
/** 文本高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
/** 改变编辑状态 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changeEditStyle;
/** 改变模板 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changeTitleOringe;
/** 开始编辑 */
- (void)starEdit;
/** 结束编辑 */
- (void)endEdit;

@end

NS_ASSUME_NONNULL_END
