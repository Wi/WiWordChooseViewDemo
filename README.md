# WiWordChooseViewDemo
一个选择的demo

Cocoapods支持：
pod 'WiWordChooseView', '~> 1.0.0'

使用示例：

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WiWordChooseView *aView = [[WiWordChooseView alloc] initWithFrame:self.view.bounds word:@"窈窕淑女君子好逑" callBack:^(BOOL isSuccess) {
        if (isSuccess)
        {
            NSLog(@"成功了~");
        }
        else
        {
            NSLog(@"失败了~");
        }
    }];
    [self.view addSubview:aView];
}
