//
//  KGInstitutionSearchView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGInstitutionSearchView : UIView

@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) void(^sendSearchResult)(NSString *result);

- (instancetype)shareInstanceWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
