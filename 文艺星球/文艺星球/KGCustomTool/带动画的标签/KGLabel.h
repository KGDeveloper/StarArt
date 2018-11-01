//
//  KGLabel.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGLabelDelegate <NSObject>

- (void)sendTitle:(NSString *)title labTag:(NSInteger)tag;

@end

/** 自定义标签 */
@interface KGLabel : UIView
/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 标签id */
@property (nonatomic,copy) NSString *labID;
/** 代理 */
@property (nonatomic,weak) id<KGLabelDelegate>delegate;

- (void)removeButton;

@end

