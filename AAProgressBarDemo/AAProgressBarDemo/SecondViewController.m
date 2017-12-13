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
#import "CustomDownLoadButton.h"
@interface SecondViewController ()

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
        
        
        
        CustomDownLoadButton *downLoadBtn = [[CustomDownLoadButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 100, 120, 120)];
        [self.view addSubview:downLoadBtn];
     }
}

@end
