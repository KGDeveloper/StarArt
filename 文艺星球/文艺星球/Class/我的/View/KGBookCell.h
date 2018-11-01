//
//  KGBookCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changeEditStyle;
@property (weak, nonatomic) IBOutlet UIImageView *customImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
@property (weak, nonatomic) IBOutlet UIImageView *fourImage;
@property (weak, nonatomic) IBOutlet UIImageView *fiveImage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeight;
/** 开始编辑 */
- (void)starEdit;
/** 结束编辑 */
- (void)endEdit;

@end

NS_ASSUME_NONNULL_END
