//
//  TextUtil.h
//  LoveBaby
//
//  Created by YUNG on 15-4-25.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "TextUtil.h"

@implementation TextUtil
+(NSString *)getTextWithTag:(NSString *)tag
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog(@"language is %@",currentLanguage);
    return NSLocalizedString(tag, nil);
    
//    if ([currentLanguage isEqualToString:@"zh-Hans"]) {
//       
//        
//    }else if ([currentLanguage isEqualToString:@"zh-Hant"]){
//    }else if ([currentLanguage isEqualToString:@"en"]){
//    }
    //资源路径
    //    _chineseImagesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Images_Chinese/"];
    //    _englishImagesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Images_English/"];
}
+(NSString *)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}
@end
