//
//  WiWordChooseView.m
//  ChildEnglish
//
//  Created by DengZw on 16/5/25.
//  Copyright © 2016年 MorningStar. All rights reserved.
//

#import "WiWordChooseView.h"
#import "WiArrayTool.h"
#import <QuartzCore/QuartzCore.h>

#define kUpButtonsGapWidth 2.0f         /**< 上面按钮的间隙*/
#define kDownButtonsGapWidth 10.0f       /**< 下面按钮的间隙*/

#define kUpButtonsSizeWidth 30.0f       /**< 上面按钮的宽度*/
#define kDownButtonsSizeWidth 30.0f      /**< 下面按钮的宽度*/

#define kUpButtonsSizeHeight 40.0f      /**< 上面按钮的高度*/
#define kDownButtonsSizeHeight 40.0f    /**< 下面按钮的高度*/

#define kArraySeparateText @"#DzwArraySeparateText#"    /**< 数组分隔符*/
#define kResultSuccessTipsText @"你对了，点此再来一次"    /**< 成功提示*/
#define kResultFailedTipsText @"你错了，点此再来一次"     /**< 错误提示*/

@interface WiWordChooseView ()

@property (nonatomic, strong) UIView *upBgView; /**< 上面的背景 */
@property (nonatomic, strong) UIView *downBgView; /**< 下面的背景 */

@property (nonatomic, strong) UIButton *btnTips; /**< 结果提示 */

@property (nonatomic, strong) NSMutableArray *upBtnsArray; /**< 上面的按钮数组 */
@property (nonatomic, strong) NSMutableArray *downBtnsArray; /**< 下面的按钮数组 */


@end

@implementation WiWordChooseView

#pragma mark - Init
#pragma mark -

/**
 *  初始化
 *
 *  @param word 单词
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame word:(NSString *)word
{
    if (self = [super initWithFrame:frame])
    {
        [self setWord:word];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
                         word:(NSString *)word
                     callBack:(WordChooseViewCallBlock)block
{
    if (self = [super initWithFrame:frame])
    {
        [self setCallBackBlock:block];
        [self setWord:word];
    }
    
    return self;
}

- (void)setWord:(NSString *)word
{
    _word = word;
    
    NSMutableArray *array = [WiArrayTool transformWordToArray:self.word];
    NSMutableArray *randomArray = [WiArrayTool sortArrayToRandomArray:array];
    
    self.upBtnsArray = [[NSMutableArray alloc] init];
    self.downBtnsArray = [[NSMutableArray alloc] init];
    
    self.downBtnsArray = randomArray;
    
    [self drawUpButtonsByArray:self.upBtnsArray];
    [self drawDownButtonsByArray:self.downBtnsArray];
}

#pragma mark - Create UI
#pragma mark -

/**
 *  画上面的按钮
 *
 *  @param array <#array description#>
 */
- (void)drawUpButtonsByArray:(NSMutableArray *)array
{
    if (self.upBgView)
    {
        [self.upBgView removeFromSuperview];
    }
    
    self.upBgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             self.bounds.size.width,
                                                             self.bounds.size.height/2)];
    self.upBgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.upBgView];
    
    NSInteger count = [[WiArrayTool transformWordToArray:self.word] count];
    CGFloat firstBtnOrignX = (self.upBgView.bounds.size.width - count * kUpButtonsSizeWidth - (count -1) * kUpButtonsGapWidth)/2;
    
    NSInteger upCount = array.count;
    for (int x = 0; x < upCount; x ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(firstBtnOrignX + x * (kUpButtonsSizeWidth + kUpButtonsGapWidth),
                                 (self.upBgView.bounds.size.height - kUpButtonsSizeHeight)/2,
                                 kUpButtonsSizeWidth,
                                 kUpButtonsSizeHeight)];
        [btn setTitle:array[x] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2.f;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [btn addTarget:self action:@selector(upBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = x;
        [self.upBgView addSubview:btn];
    }
    
    // 填充没有字的格子
    for (NSInteger x = upCount; x < count; x ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(firstBtnOrignX + x * (kUpButtonsSizeWidth + kUpButtonsGapWidth),
                                 (self.upBgView.bounds.size.height - kUpButtonsSizeHeight)/2,
                                 kUpButtonsSizeWidth,
                                 kUpButtonsSizeHeight)];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2.f;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.tag = x;
        NSRange range = NSMakeRange(x, 1);
        NSString *str = [self.word substringWithRange:range];
        [btn setTitle:str forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(tmpBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.upBgView addSubview:btn];
    }
}


/**
 *  画下面的按钮
 *
 *  @param array <#array description#>
 */
- (void)drawDownButtonsByArray:(NSMutableArray *)array
{
    if (self.downBgView)
    {
        [self.downBgView removeFromSuperview];
    }
    
    self.downBgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               self.frame.size.height/2,
                                                               self.frame.size.width,
                                                               self.frame.size.height/2)];
    self.downBgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.downBgView];
    

    NSInteger count = array.count;
    CGFloat firstBtnOrignX = (self.downBgView.bounds.size.width - count * kDownButtonsSizeWidth - (count -1) * kDownButtonsGapWidth)/2;
    for (int x = 0; x < count; x ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(firstBtnOrignX + x * (kDownButtonsSizeWidth + kDownButtonsGapWidth),
                                 (self.downBgView.bounds.size.height - kDownButtonsSizeHeight)/2,
                                 kDownButtonsSizeWidth,
                                 kDownButtonsSizeHeight)];
        [btn setTitle:array[x] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2.f;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.tag = x;
        [btn addTarget:self action:@selector(downBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.downBgView addSubview:btn];
    }
}


// 创建提示Label
- (void)creatTipsButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:self.downBgView.bounds];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnRetryAction) forControlEvents:UIControlEventTouchUpInside];
    [self.downBgView addSubview:btn];
    self.btnTips = btn;
}

#pragma mark - Button Action
#pragma mark -
// 重试
- (void)btnRetryAction
{
    [self setWord:_word];
}

// 上面的按钮事件
- (void)upBtnsAction:(UIButton *)btn
{
    if (self.btnTips && self.downBgView)
    {
        [self.btnTips setTitle:@"" forState:UIControlStateNormal];
    }
    
    NSString *str = btn.titleLabel.text;
    NSInteger tag = btn.tag;
    
    [self.upBtnsArray removeObjectAtIndex:tag];
    [self.downBtnsArray addObject:str];
    
    [self drawUpButtonsByArray:self.upBtnsArray];
    [self drawDownButtonsByArray:self.downBtnsArray];
}

// 下面的按钮事件
- (void)downBtnsAction:(UIButton *)btn
{
    NSString *str = btn.titleLabel.text;
    NSInteger tag = btn.tag;
    
    [self.downBtnsArray removeObjectAtIndex:tag];
    [self.upBtnsArray addObject:str];
    
    [self drawUpButtonsByArray:self.upBtnsArray];
    [self drawDownButtonsByArray:self.downBtnsArray];
    
    // 单词选择已完成 - 显示结果
    if (self.upBtnsArray.count == self.word.length)
    {
        NSString *str = [self.upBtnsArray componentsJoinedByString:kArraySeparateText];
        str = [str stringByReplacingOccurrencesOfString:kArraySeparateText withString:@""];
        
        [self creatTipsButton];
        
        BOOL isSuccess;
        
        if ([str isEqualToString:self.word])
        {
            [self.btnTips setTitle:kResultSuccessTipsText forState:UIControlStateNormal];
            isSuccess = YES;
        }
        else
        {
            [self.btnTips setTitle:kResultFailedTipsText forState:UIControlStateNormal];
            isSuccess = NO;
        }
        
        if (self.callBackBlock)
        {
            self.callBackBlock(isSuccess);
        }
    }
}

// 空按钮事件 - 高亮状态提示用户
- (void)tmpBtnsAction:(UIButton *)btn
{
    //
}


@end
