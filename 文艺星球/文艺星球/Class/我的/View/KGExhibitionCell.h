//
//  KGExhibitionCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGExhibitionCell : UITableViewCell
/** 编辑view */
@property (weak, nonatomic) IBOutlet UIView *editView;
/** 选择 */
@property (weak, nonatomic) IBOutlet UIButton *chooseBtu;
/** 改变编辑状态 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changeEditStyle;
/** 展览图片 */
@property (weak, nonatomic) IBOutlet UIImageView *customImage;
/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *adressLab;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/** 开始编辑 */
- (void)starEdit;
/** 结束编辑 */
- (void)endEdit;

@end

NS_ASSUME_NONNULL_END
