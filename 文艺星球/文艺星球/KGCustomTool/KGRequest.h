//
//  KGRequest.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGRequest : NSObject
/** 初始化 */
+ (instancetype)shareInstance;
/** POST请求 */
+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)dic
               succ:(void(^)(id result))succ
               fail:(void(^)(NSError *error))fail;
/** 修正图片方向 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;
/** 获取视频第一帧 */
- (UIImage *)thumbnailImageForVideo:(NSURL *)video;
/** 上传图片到七牛云 */
- (void)uploadImageToQiniuWithFile:(NSString *)filePath result:(void(^)(NSString *strPath))uploadData;
/** 照片获取本地路径转换 */
- (NSString *)getImagePath:(UIImage *)Image;

@end

NS_ASSUME_NONNULL_END
