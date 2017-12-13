//
//  CustomDownLoadButton.m
//  AAProgressBarDemo
//
//  Created by AnAn on 2017/12/13.
//  Copyright © 2017年 An An. All rights reserved.
//

#import "CustomDownLoadButton.h"
#import "AACircularProgressBar.h"
#import "AARippleView.h"

@interface CustomDownLoadButton() {
    AACircularProgressBar *_circleProgressBar;
    AARippleView *_rippleView;
}
@property (nonatomic, assign) BOOL isWorking;
@end

@implementation CustomDownLoadButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpTheCircularProgressBar];
        [self setUpTheBackgroundRippleView];
        [self bringSubviewToFront:_circleProgressBar];
    }
    return self;
}

- (void)setUpTheCircularProgressBar {
    _circleProgressBar = [[AACircularProgressBar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
    _circleProgressBar.maxValue = 200;
    _circleProgressBar.unitString = @"下载中";
    [self addSubview:_circleProgressBar];
    _circleProgressBar.value = arc4random()%200;
    
    [self configureTheSingleTapgesture];
    
}

- (void)setUpTheBackgroundRippleView {
    _rippleView = [[AARippleView alloc]init];
    _rippleView.center = _circleProgressBar.center;
    _rippleView.bounds = CGRectMake(0,0,_circleProgressBar.bounds.size.width*2, _circleProgressBar.bounds.size.width*2);
    [self addSubview:_rippleView];
//    [rippleView beginAnimation];
}

- (void)configureTheSingleTapgesture {
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapEvent)];
    singleTapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTapGesture];
    

    
}

- (void)singleTapEvent {
    if (self.isWorking == YES) {
        [self stopWorking];
    } else {
        [self startWorking];
    }
    self.isWorking = !self.isWorking;
}

- (void)startWorking {
    [_rippleView beginAnimation];
}

- (void)stopWorking {
    [_rippleView stopAnimation];
}

@end
