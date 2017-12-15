//
//  AADownLoadButton.m
//  AAProgressBarDemo
//
//  Created by AnAn on 2017/12/13.
//  Copyright © 2017年 An An. All rights reserved.
//

#import "AADownLoadButton.h"
#import "AACircularProgressBar.h"
#import "AARippleView.h"
#import "AADrawLineWithAnimationView.h"

@interface AADownLoadButton() {
    AACircularProgressBar *_circleProgressBar;
    AARippleView *_rippleView;
    UILabel *_contentLabel;
    AADrawLineWithAnimationView *lineView;
    

}

@end

@implementation AADownLoadButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpTheCircularProgressBar];
        [self setUpTheBackgroundRippleView];
        [self bringSubviewToFront:_circleProgressBar];
        [self setUpTheTextContentLabel];
        
        lineView = [[AADrawLineWithAnimationView alloc]init];
//        lineView.center = self.center;
//        lineView.bounds = CGRectMake(0, 0, self.bounds.size.width*0.2, self.bounds.size.height*0.2);
        
        lineView.center = _circleProgressBar.center;
        lineView.bounds = CGRectMake(0,0,_circleProgressBar.bounds.size.width*0.17, _circleProgressBar.bounds.size.width*0.17);
        [lineView setUpTheUIViews];
        [self addSubview:lineView];
    }
    return self;
}

- (void)setUpTheCircularProgressBar {
    _circleProgressBar = [[AACircularProgressBar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
     _circleProgressBar.maxValue = 100;
    [self addSubview:_circleProgressBar];
    
    [self configureTheSingleTapgesture];
    
}

- (void)setUpTheBackgroundRippleView {
    _rippleView = [[AARippleView alloc]init];
    _rippleView.center = _circleProgressBar.center;
    _rippleView.bounds = CGRectMake(0,0,_circleProgressBar.bounds.size.width*2, _circleProgressBar.bounds.size.width*2);
    [self addSubview:_rippleView];
//    [rippleView beginAnimation];
}

- (void)setUpTheTextContentLabel {
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, 30);
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height+20);
    _contentLabel.center = center;
    [self addSubview:_contentLabel];
    
    _contentLabel.attributedText = [self configureTheTextContent:_progressValue];

}



- (NSAttributedString *)configureTheTextContent:(float )progressValue {
    
    float textValue = [self roundFloat:progressValue];
    NSNumber *valueNum = [NSNumber numberWithFloat:textValue*100];
    NSString *textContent = [NSString stringWithFormat:@"%@",valueNum];
    
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* valueFontAttributes = @{NSFontAttributeName:[UIFont fontWithName: @"HelveticaNeue-Bold" size:27],
                                          NSForegroundColorAttributeName:[UIColor blueColor],
                                          NSParagraphStyleAttributeName:textStyle};
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NSAttributedString* value = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",textContent] attributes:valueFontAttributes];
    
    [text appendAttributedString:value];
    
    
    NSDictionary* unitFontAttributes = @{NSFontAttributeName:[UIFont fontWithName: @"HelveticaNeue" size:13],
                                         NSForegroundColorAttributeName:[UIColor grayColor],
                                         NSParagraphStyleAttributeName:textStyle};
    
    NSString *downloadStateStr = _isWorking == YES?@"下载中":@"暂停中";
    
    NSAttributedString* unit = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ",downloadStateStr] attributes:unitFontAttributes];
    [text appendAttributedString:unit];
    return text;
}


- (void)configureTheSingleTapgesture {
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapEvent)];
    singleTapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTapGesture];
}

- (void)singleTapEvent {
    _isWorking = !_isWorking;
    if (_isWorking == YES) {
        [_rippleView beginAnimation];
       lineView.isDownloading = YES;
    } else {
        [_rippleView stopAnimation];
        lineView.isDownloading = NO;;
    }
    
    _contentLabel.attributedText = [self configureTheTextContent:_progressValue];

    
    if (self.didSelectedBlock != nil) {
        self.didSelectedBlock(_isWorking);
    } else {
        [self.didSelectedDelegate AADownLoadButtonDidSelectedWithWorkingState:_isWorking];
    }
}

#pragma mark - setter method
- (void)setProgressValue:(CGFloat)progressValue {
    _progressValue = progressValue;
    _circleProgressBar.value = _progressValue*100;
    
    if (_progressValue >= 1) {
        [_rippleView stopAnimation];
        lineView.isDownloading = NO;
        self.userInteractionEnabled  = NO;
        _contentLabel.attributedText = [self configureTheTextContent:1];
        return;
    }
    
    _contentLabel.attributedText = [self configureTheTextContent:_progressValue];
}

//小数只保留小数点后两位
- (float)roundFloat:(float)price {
    NSString *temp = [NSString stringWithFormat:@"%f",price];
    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:temp];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                             scale:4
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:YES];
    return [[numResult decimalNumberByRoundingAccordingToBehavior:roundUp] floatValue];
}

- (void)setIsWorking:(BOOL)isWorking {
    _isWorking = isWorking;
    if (isWorking) {
        [_rippleView beginAnimation];
        lineView.isDownloading = YES;
    } else {
        [_rippleView stopAnimation];
        lineView.isDownloading = NO;
    }
    
}



@end
