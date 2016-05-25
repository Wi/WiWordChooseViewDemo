//
//  WiWordChooseView.h
//  ChildEnglish
//
//  Created by DengZw on 16/5/25.
//  Copyright © 2016年 MorningStar. All rights reserved.
//

/**
 一个单词选择的控件
 */

#import <UIKit/UIKit.h>

typedef void(^WordChooseViewCallBlock)(BOOL isSuccess);

@interface WiWordChooseView : UIView

/**
 *  初始化
 *
 *  @param frame 视图大小
 *  @param word  单词
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame word:(NSString *)word;

/**
 *  初始化
 *
 *  @param frame <#frame description#>
 *  @param word  <#word description#>
 *  @param block 回调block
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame
                         word:(NSString *)word
                     callBack:(WordChooseViewCallBlock)block;

/**
 *  如果用Storyboard创建View，需setWord
 */
@property (nonatomic, strong) NSString *word; /**< 单词*/
@property (nonatomic, weak) WordChooseViewCallBlock callBackBlock; /**< 回调方法 */

@end
