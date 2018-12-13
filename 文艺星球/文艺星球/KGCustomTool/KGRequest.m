//
//  KGRequest.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGRequest.h"
#import <AVFoundation/AVFoundation.h>
#import "QiniuSDK.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@implementation KGRequest

+ (instancetype)shareInstance{
    static KGRequest *request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[KGRequest alloc]init];
    });
    return request;
}
/** POST请求 */
+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)dic
               succ:(void(^)(id result))succ
               fail:(void(^)(NSError *error))fail{
    AFHTTPSessionManager *manager = [KGRequest managerWithBaseUrl:nil sessionCofiguration:NO];
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id respond = [KGRequest responseConfiguration:responseObject];
        succ(respond);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}
/** 创建请求管理类 */
+ (AFHTTPSessionManager *)managerWithBaseUrl:(NSString *)baseUrl sessionCofiguration:(BOOL)iscofiguration{
    /** 上传下载策略 */
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = nil;
    NSURL *url = [NSURL URLWithString:baseUrl];
    if (iscofiguration) {
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    }
    /** 响应策略 */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /** 验证证书 */
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    manager.securityPolicy = security;
    /** 编码序列化 */
    AFJSONRequestSerializer *requestSerialzer = [AFJSONRequestSerializer serializer];
    [requestSerialzer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerialzer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    if ([KGUserInfo shareInstance].userToken) {
        [requestSerialzer setValue:[NSString stringWithFormat:@"Bearer %@",[KGUserInfo shareInstance].userToken] forHTTPHeaderField:@"Authorization"];
    }
    manager.requestSerializer = requestSerialzer;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    return manager;
}
/** 验证证书 */
+ (id)responseConfiguration:(id)responseObject{
    NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}
/** 获取视频第一帧 */
- (UIImage *)thumbnailImageForVideo:(NSURL *)video{
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:video options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 1;
    NSError *error = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&error];
    if (!thumbnailImageRef) {
        
    }
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
}
/** 修正图片方向 */
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
/** 上传图片 */
- (void)uploadImageToQiniuWithFile:(NSString *)filePath result:(void(^)(NSString *strPath))uploadData{
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    
    [KGRequest postWithUrl:QiNiuToken parameters:@{} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            [upManager putFile:filePath key:[[NSString alloc] initWithFormat:@"%@.png",[self getNowTimestamp]] token:dic[@"tokencode"] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                if (info.statusCode == 200) {
                    NSString *path = @"http://image.iartplanet.com/";
                    path = [path stringByAppendingString:resp[@"key"]];
                    uploadData(path);
                }
            } option:uploadOption];
        }
    } fail:^(NSError * _Nonnull error) {
        
    }];
}
//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image{
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/%@.png",[self getNowTimestamp]];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@",DocumentsPath, ImagePath];
    return filePath;
}

- (NSString *)getNowTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%u%ld",arc4random_uniform(100),(long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}
/** 获取当前位置 */
- (void)requestYourLocation:(void(^)(CLLocationCoordinate2D location))yourLocation{
    _manager = [[AMapLocationManager alloc]init];
    [_manager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    _manager.locationTimeout = 2;
    _manager.reGeocodeTimeout = 2;
    __block CLLocationCoordinate2D tmpLocation;
    [_manager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            tmpLocation = CLLocationCoordinate2DMake(39.987094,116.491390);
            yourLocation(tmpLocation);
            return;
        }
        tmpLocation = location.coordinate;
        yourLocation(tmpLocation);
    }];
}
/** 获取当前城市 */
- (void)userLocationCity:(void(^)(NSString *city))city{
    _manager = [[AMapLocationManager alloc]init];
    [_manager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    _manager.locationTimeout = 2;
    _manager.reGeocodeTimeout = 2;
    __block NSString *userCity = nil;
    [_manager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            userCity = @"北京市";
            city(userCity);
            return;
        }
        userCity = regeocode.city;
        city(userCity);
    }];
}

@end
