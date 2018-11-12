//
//  KGAgencyExhibitionDetailHeaderView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGAgencyExhibitionDetailHeaderView.h"

@interface KGAgencyExhibitionDetailHeaderView ()

@end

@implementation KGAgencyExhibitionDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.maskView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.2];
    
}
- (IBAction)selectLocation:(UIButton *)sender {
}

@end
