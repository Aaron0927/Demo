//
//  LanguageManager.h
//  ios_language_manager
//
//  Created by Maxim Bilan on 12/23/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ELanguage)
{
    ELanguageEnglish,
    ELanguageGerman,
    ELanguageFrench,
	ELanguageArabic,
	
    ELanguageCount
};

@interface LanguageManager : NSObject

+ (void)setupCurrentLanguage;
+ (NSArray *)languageStrings;
// 获取当前语言 "English"
+ (NSString *)currentLanguageString;
// 获取当前语言的简写 “en”
+ (NSString *)currentLanguageCode;
// 获取当前语言的下标
+ (NSInteger)currentLanguageIndex;
// 保存当前语言
+ (void)saveLanguageByIndex:(NSInteger)index;
// 判断文字的方向是否从右到左
+ (BOOL)isCurrentLanguageRTL;

@end
