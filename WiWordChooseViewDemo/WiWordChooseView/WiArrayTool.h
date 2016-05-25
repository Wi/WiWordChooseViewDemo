//
//  WiArrayTool.h
//  ChildEnglish
//
//  Created by DengZw on 16/5/25.
//  Copyright © 2016年 MorningStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WiArrayTool : NSObject

/**
 *  单词转换成数组
 *
 *  @param word 单词 NSString
 *
 *  @return 数组 NSMutableArray
 */
+ (NSMutableArray *)transformWordToArray:(NSString *)word;

/**
 *  随机排序数组
 *
 *  @param array 数组 NSMutableArray
 *
 *  @return 随机排序后的数组 NSMutableArray
 */
+ (NSMutableArray *)sortArrayToRandomArray:(NSMutableArray *)array;

@end
