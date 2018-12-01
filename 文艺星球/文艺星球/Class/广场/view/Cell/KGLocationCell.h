//
//  KGLocationCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIImageView *chooseStyle;

@end

NS_ASSUME_NONNULL_END
