//
//  SecondViewController.m
//  AAProgressBarDemo
//
//  Created by An An on 2017/10/11.
//  Copyright © 2017年 An An. All rights reserved.
//

#import "SecondViewController.h"
//#import "AAProgressBar.h"
#import "AALinearProgressBar.h"
#import "AACircularProgressBar.h"
#import "AARippleView.h"
#import "AADownLoadButton.h"
@interface SecondViewController ()<AADownLoadButtonDidSelectedDelegate> {
    NSTimer *_timer;
    AADownLoadButton *downLoadBtn;
}

@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.progressBarType isEqualToString:@"linear"]) {
        AALinearProgressBar *linearProgressBar = [[AALinearProgressBar alloc]initWithFrame:CGRectMake(20, 300, 200, 50)];
//        linearProgressBar.backgroundColor = [UIColor grayColor];
        linearProgressBar.trackLineColor = [UIColor blueColor];
        linearProgressBar.progressLineColor = [UIColor redColor];
        linearProgressBar.maxValue = 100;
        [self.view addSubview:linearProgressBar];
//        [UIView animateWithDuration:1 animations:^{
            linearProgressBar.value = arc4random()%100;
//        }];
    } else {
//        AACircularProgressBar *circleProgressBar = [[AACircularProgressBar alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 100, 120, 120)];
//        circleProgressBar.maxValue = 200;
//        circleProgressBar.unitString = @"下载中";
//        [self.view addSubview:circleProgressBar];
//        circleProgressBar.value = arc4random()%200;
////
//        AARippleView *rippleView = [[AARippleView alloc]init];
//        rippleView.center = circleProgressBar.center;
//        rippleView.bounds = CGRectMake(0,0,circleProgressBar.bounds.size.width*2, circleProgressBar.bounds.size.width*2);
//        [self.view addSubview:rippleView];
//
//        [self.view bringSubviewToFront:circleProgressBar];
//
//        [rippleView beginAnimation];
        
        
        
        downLoadBtn = [[AADownLoadButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 100, 120, 120)];
        [self.view addSubview:downLoadBtn];
        
        
        downLoadBtn.progressValue = 0.67;
        downLoadBtn.isWorking = YES;
        downLoadBtn.didSelectedDelegate = self;
        
        
//        downLoadBtn.didSelectedBlock = ^(BOOL isWorking) {
//
//        };
        
//        [self virtualUpdateTheChartViewDataInRealTime];
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(0, 200, 50, 50);
//        button.backgroundColor = [UIColor redColor];
//        [self.view addSubview:button];
//        [button addTarget:self action:@selector(buttonClickedHa) forControlEvents:UIControlEventTouchUpInside];
        
     
     }
}

- (void)virtualUpdateTheChartViewDataInRealTime{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                              target:self
                                            selector:@selector(timerStartWork)
                                            userInfo:nil
                                             repeats:YES];
    [_timer fire];
}

- (void)timerStartWork {
    downLoadBtn.progressValue =  downLoadBtn.progressValue+0.01;
    
    NSLog(@"定时器开启了%@",[NSNumber numberWithFloat:downLoadBtn.progressValue]);
}

- (void)buttonClickedHa {
    CGFloat value = arc4random()%100*0.01;
    downLoadBtn.progressValue = arc4random()%100*0.01;
    downLoadBtn.isWorking = YES;
    NSLog(@"定时器开启了%@",[NSNumber numberWithFloat:value]);

}


- (void)AADownLoadButtonDidSelectedWithWorkingState:(BOOL)isWorking {
    NSString *str = isWorking ==YES?@"当前状态是正在下载中":@"当前状态是暂停中";
    
    
    
    
    
    
    NSLog(@"%@",str);
}




@end
