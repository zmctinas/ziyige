//
//  QRCodeGenerator.m
//  Diamond
//
//  Created by Pan on 15/7/25.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "QRCodeGenerator.h"
#import "qrencode.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define kCGImageAlphaPremultipliedLast  (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)
#else
#define kCGImageAlphaPremultipliedLast  kCGImageAlphaPremultipliedLast
#endif


@implementation QRCodeGenerator

//#import "QRCodeGenerator.h"
//#import "qrencode.h"

enum {
    qr_margin = 3
};

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    // draw
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
    for(int i = 0; i < width; ++i) {
        for(int j = 0; j < width; ++j) {
            if(*data & 1) {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size {
    
    int sizeIntable = size + 0.5;
    CGFloat reSize = sizeIntable;
    
    if (![string length]) {
        return nil;
    }
    
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, reSize, reSize, 8, reSize * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -reSize);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [QRCodeGenerator drawQRCode:code context:ctx size:reSize];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
}

+ (UIImage *) twoDimensionCodeImage:(UIImage *)twoDimensionCode withAvatarImage:(UIImage *)avatarImage{
    
    // two-dimension code 二维码
    
    CGSize size = twoDimensionCode.size;
    
    CGSize size2 =CGSizeMake(1.0 / 5.5 * size.width, 1.0 / 5.5 * size.height);
    
    
    
    UIGraphicsBeginImageContext(size);
    
    
    
    [twoDimensionCode drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    [[self avatarImage:avatarImage] drawInRect:CGRectMake((size.width - size2.width) / 2.0, (size.height - size2.height) / 2.0, size2.width, size2.height)];
    
    
    
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
    
}


+ (UIImage *) avatarImage:(UIImage *)avatarImage{
    
    UIImage * avatarBackgroudImage = [UIImage imageNamed:@"icon.png"];
    
    CGSize size = avatarBackgroudImage.size;
    
    UIGraphicsBeginImageContext(size);
    
    
    
    [avatarBackgroudImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    [avatarImage drawInRect:CGRectMake(10, 10, size.width - 20, size.height - 20)];
    
    
    
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
    
}



@end
