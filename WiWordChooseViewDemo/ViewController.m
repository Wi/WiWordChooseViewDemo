//
//  ViewController.m
//  WiWordChooseViewDemo
//
//  Created by DengZw on 16/5/25.
//  Copyright © 2016年 MorningStar. All rights reserved.
//

#import "ViewController.h"
#import "WiWordChooseView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet WiWordChooseView *wordChooseView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // set word
    [self.wordChooseView setWord:@"窈窕淑女君子好逑"];
    
    // set block
    [self.wordChooseView setCallBackBlock:^(BOOL isSuccess){
        if (isSuccess)
        {
            NSLog(@"成功了~");
        }
        else
        {
            NSLog(@"失败了~");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
