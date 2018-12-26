//
//  DGImageTool.m
//  DGTool
//
//  Created by david on 2018/9/28.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGImageTool.h"

@implementation DGImageTool

#pragma mark - color
/** 获取图片最多的那个颜色 */
+(UIColor*)mostColorForImage:(UIImage *)image {
    return [self mostColorForImage:image ignoreDeviation:0];
}

/** 获取图片最多的那个颜色 可设定忽略颜色偏差 */
+(UIColor*)mostColorForImage:(UIImage*)image ignoreDeviation:(NSUInteger)deviation{
    
    //0.过滤nil
    if(!image){
        return nil;
    }
    
    //1. 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    if(image.size.width > 40.0){
        CGFloat targetWidth = 40.0;
        CGFloat targetHeight = image.size.height * (targetWidth/image.size.width);
        image = [self scaleImage:image toSize:CGSizeMake(targetWidth, targetHeight)];
    }
    //CGSize thumbSize = CGSizeMake(image.size.width, image.size.height);
    CGFloat pixelW = CGImageGetWidth(image.CGImage);
    CGFloat pixelH = CGImageGetHeight(image.CGImage);
    
    //2. 获取像素数据
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 pixelW,
                                                 pixelH,
                                                 8,//bits per component
                                                 0,
                                                 colorSpace,
                                                 bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, pixelW, pixelH);
    CGContextDrawImage(context, drawRect, image.CGImage);//decode
    //CGImageRef newImage = CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    
    //3.取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:pixelW * pixelH];
    
    for (int x=0; x<pixelW; x++) {
        for (int y=0; y<pixelH; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (abs(red-green)<deviation && abs(red-blue)<deviation && abs(green-blue)<deviation) {//要忽略的颜色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
            }
        }
    }
    CGContextRelease(context);
    
    //4. 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor = nil;
    NSUInteger MaxCount = 0;
    while ( (curColor = [enumerator nextObject]) != nil ){
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount = tmpCount;
        MaxColor = curColor;
    }
    
    //5. return
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

#pragma mark - image
/** 画圆角矩形 */
+ (UIImage *)imageWithBgColor:(UIColor *)bgColor size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
    
    //size处理
    if(size.width<=0 || size.height<=0){
        size = CGSizeMake(50, 50);
    }
    
    //1.画image
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    //CGContextRef contentRef = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    [path addClip];
    [bgColor setFill];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //2.可拉伸
    UIEdgeInsets insets = UIEdgeInsetsMake(0, size.height/2.0 + 1, 0, size.height/2.0 +1);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    //3.return
    return image;
}

/** 图片缩放到指定大小尺寸 */
+ (UIImage *)scaleImage:(UIImage *)img toSize:(CGSize)size{
    //①
//    CGFloat scale = [[UIScreen mainScreen] scale];
//    if(scale == 2.0){
//        UIGraphicsBeginImageContextWithOptions(size,NO, 2.0);
//    }else if(scale == 3.0){
//        UIGraphicsBeginImageContextWithOptions(size,NO, 3.0);
//    }else{
//        UIGraphicsBeginImageContext(size);
//    }
    //② 和①效果相同
    UIGraphicsBeginImageContextWithOptions(size,NO, 0.0);
    
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

/** 给图片画文字 */
+ (UIImage *)addText:(NSString *)text toImage:(UIImage *)image attributes:(NSDictionary<NSString *, id> *)attributes leftEdge:(CGFloat)left topEdge:(CGFloat)top {
    
    //0.创建画布
    CGSize size=CGSizeMake(image.size.width,image.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    //1.画图片
    [image drawAtPoint:CGPointMake(0.0,0.0)];
    
    //2.画text
    //计算文字所占的size,文字居中显示在画布上
    CGSize sizeText=[text boundingRectWithSize:image.size options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes context:nil].size;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (left < 0) {
        left = (width-sizeText.width)/2;
    }
    if (top < 0) {
        top = (height-sizeText.height)/2;
    }
    CGRect rect = CGRectMake(left,top,sizeText.width, sizeText.height);
    [text drawInRect:rect withAttributes:attributes];
    
    //3.获取画好的imge
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //4.return
    return newImage;
    
}

@end
