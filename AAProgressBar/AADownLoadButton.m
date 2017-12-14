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

@interface AADownLoadButton() {
    AACircularProgressBar *_circleProgressBar;
    AARippleView *_rippleView;
    UILabel *_contentLabel;
    

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
    //    _contentLabel.center = self.center;
    
    NSNumber *valueNum = [NSNumber numberWithFloat:_progressValue];
    
    _contentLabel.attributedText = [self configureTheTextContent:[NSString stringWithFormat:@"%@",valueNum]];

}

- (NSAttributedString *)configureTheTextContent:(NSString *)textContent {
    
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
    self.isWorking = !self.isWorking;
    if (self.isWorking == YES) {
        [_rippleView beginAnimation];
    } else {
        [_rippleView stopAnimation];
    }
    
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

    NSNumber *valueNum = [NSNumber numberWithFloat:_progressValue*100];
    _contentLabel.attributedText = [self configureTheTextContent:[NSString stringWithFormat:@"%@",valueNum]];
}

- (void)setIsWorking:(BOOL)isWorking {
    _isWorking = isWorking;
    [_rippleView beginAnimation];
}




@end
