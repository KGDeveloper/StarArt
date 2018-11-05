//
//  KGReleaseTF.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGReleaseTF.h"

@implementation KGReleaseTF

/** 修改frame */
- (CGRect)textRectForBounds:(CGRect)bounds{
    bounds.size.width  -= 85;
    bounds.origin.x += 35;
    return bounds;
}
/** 修改左侧显示view */
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x + 20, 0, 15, bounds.size.height);
}
/** 修改左侧显示view */
- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.size.width - 50, 0, 50, bounds.size.height);
}
/** 设置预留字位置 */
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    bounds.origin.x += 35;
    return bounds;
}
/** 设置编辑文本位置 */
- (CGRect)editingRectForBounds:(CGRect)bounds{
    bounds.origin.x += 35;
    return bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
