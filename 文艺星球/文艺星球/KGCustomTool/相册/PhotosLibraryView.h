/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/23
 
 Copyright (c) 2017 My Company
 
 ☆★☆★☆★☆★☆★☆★☆★☆★☆
 ★　　│　心想　│　事成　│　　★
 ☆别╭═╮　　 ╭═╮　　 ╭═╮别☆
 ★恋│人│　　│奎│　　│幸│恋★
 ☆　│氣│　　│哥│　　│福│　☆
 ★　│超│　　│制│　　│滿│　★
 ☆别│旺│　　│作│　　│滿│别☆
 ★恋│㊣│　　│㊣│　　│㊣│恋★
 ☆　╰═╯ 天天╰═╯ 開心╰═╯　☆
 ★☆★☆★☆★☆★☆★☆★☆★☆★.
 
 */

#import <UIKit/UIKit.h>
/** 相册 */
@interface PhotosLibraryView : UIView
/** 发送选择的图片数组 */
@property (nonatomic,copy) void(^chooseImageFromPhotoLibary)(NSArray<UIImage *> *imageArr);
/** 设置最大选择数 */
@property (nonatomic,assign) NSInteger maxCount;

@end
/** 保存图片的模型 */
@interface PhotosLibraryViewModel :NSObject
/** 保存图片 */
@property (nonatomic,strong) UIImage *image;

@end
