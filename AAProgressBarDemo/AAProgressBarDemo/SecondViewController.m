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
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.progressBarType isEqualToString:@"linear"]) {
        AALinearProgressBar *linearProgressBar = [[AALinearProgressBar alloc]initWithFrame:CGRectMake(20, 100, 200, 50)];
        linearProgressBar.trackLineColor = [UIColor blueColor];
        linearProgressBar.progressLineColor = [UIColor redColor];
        linearProgressBar.maxValue = 100;
        [self.view addSubview:linearProgressBar];
        [UIView animateWithDuration:1 animations:^{
            linearProgressBar.value = arc4random()%100;
        }];
    } else {
        AACircularProgressBar *circleProgressBar = [[AACircularProgressBar alloc]initWithFrame:CGRectMake(20, 100, 200, 200)];
        circleProgressBar.maxValue = 200;
        circleProgressBar.unitString = @"万元";
        [self.view addSubview:circleProgressBar];
//        [UIView animateWithDuration:1 animations:^{
            circleProgressBar.value = arc4random()%200;
//        }];
    }
}

@end
