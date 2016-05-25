//
//  WiArrayTool.m
//  ChildEnglish
//
//  Created by DengZw on 16/5/25.
//  Copyright © 2016年 MorningStar. All rights reserved.
//

#import "WiArrayTool.h"

@implementation WiArrayTool

/**
 *  单词转换成数组
 *
 *  @param word 单词 NSString
 *
 *  @return 数组 NSMutableArray
 */
+ (NSMutableArray *)transformWordToArray:(NSString *)word
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if (word && ![word isEqualToString:@""])
    {
        for (int x = 0; x < word.length; x ++)
        {
            NSRange range = NSMakeRange(x, 1);
            NSString *nStr = [word substringWithRange:range];
            
            [array addObject:nStr];
        }
    }
    
    return array;
}


/**
 *  随机排序数组
 *
 *  @param array <#array description#>
 *
 *  @return 随机数组
 */
+ (NSMutableArray *)sortArrayToRandomArray:(NSMutableArray *)array
{
    NSMutableArray *randomArray = [NSMutableArray arrayWithArray:array];
    
    srandom((unsigned int)time(NULL));
    
    NSInteger count = randomArray.count;
    for (int i = 0; i < count; i++)
    {
        NSInteger target = random() % count;
        
        //swap
        NSString *str = [randomArray objectAtIndex:target];
        [randomArray replaceObjectAtIndex:target withObject:[randomArray objectAtIndex:i]];
        [randomArray replaceObjectAtIndex:i withObject:str];
    }
    
    return randomArray;
}


@end
