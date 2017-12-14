//
//  AACircularProgressBar.m
//  AAProgressBarDemo
//
//  Created by An An on 2017/8/29.
//  Copyright © 2017年 An An. All rights reserved.
//

#import "AACircularProgressBar.h"
@interface AACircularProgressBar()


#define kProgressBarThemeColor   [self colorWithHexString:@"#b89062"]


@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) CGFloat lastValue;

@end

@implementation AACircularProgressBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpBasicContent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBasicContent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpBasicContent];
    }
    return self;
}

- (void)setUpBasicContent {
    self.lastValue = 0;
    [self drawTrackCircle];
    [self drawProgressCircle];
     [self configureSelfShadowEffect];
}


- (void)drawTrackCircle {

    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = self.bounds.size.width/2-6;
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    [trackPath addArcWithCenter:center
                         radius:radius
                     startAngle:0
                       endAngle:2*M_PI
                      clockwise:YES];
    
    _trackLayer = [CAShapeLayer layer];
    _trackLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _trackLayer.lineWidth = 10.f;
//    _trackLayer.strokeColor = [UIColor grayColor].CGColor;
//    _trackLayer.borderWidth = 3;
//    _trackLayer.borderColor = [UIColor purpleColor].CGColor;
    _trackLayer.fillColor = self.backgroundColor.CGColor;
    _trackLayer.lineCap = kCALineCapSquare;
    _trackLayer.path=trackPath.CGPath;
    [self.layer addSublayer:_trackLayer];

}

- (void)drawProgressCircle {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = self.bounds.size.width/2-2;
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //    各个参数的意义：
    //    center：圆心的坐标
    //    radius：半径
    //    startAngle：起始的弧度
    //    endAngle：圆弧结束的弧度
    //    clockwise：YES为顺时针，No为逆时针
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0
                  endAngle:2*M_PI
                 clockwise:YES];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.lineWidth = 4.f;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.strokeColor = kProgressBarThemeColor.CGColor;
    _progressLayer.path = path.CGPath;


    [self.layer addSublayer:_progressLayer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _progressLayer.frame;
    gradientLayer.colors = @[(__bridge id)kProgressBarThemeColor.CGColor,(__bridge id)[self colorWithHexString:@"#fae2ad"].CGColor ];
    gradientLayer.startPoint = CGPointMake(0.5,0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    
    [self.layer addSublayer:gradientLayer];
    //Using arc as a mask instead of adding it as a sublayer.
    //[self.view.layer addSublayer:arc];
    gradientLayer.mask = _progressLayer;
}



- (void)configureSelfShadowEffect {
    self.backgroundColor = [UIColor whiteColor];
    CGFloat cornerRadius =  self.frame.size.width/2;
    self.layer.cornerRadius = cornerRadius;
    //        self.layer.masksToBounds = YES;
    //        self.clipsToBounds =YES;
    self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(1.5,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.layer.shadowRadius = 5;//阴影半径，默认3
}


- (void)startAnimation {
    _progressLayer.hidden = NO;
    CGFloat currentSelfValue = self.value;
    CGFloat currentSelfMaxValue = self.maxValue;
    
    if (currentSelfValue >= currentSelfMaxValue) {
        currentSelfValue = currentSelfMaxValue;//兼容实际值远超最大值的情况,避免重复绘制
    }
    
    CGFloat progressValue = currentSelfValue/currentSelfMaxValue;
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 1.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:self.lastValue];
    pathAnima.toValue = [NSNumber numberWithFloat:progressValue];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [_progressLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    [self performSelector:@selector(hideTheZeroValueBeziel) withObject:nil/*可传任意类型参数*/ afterDelay:1.0f];
    self.lastValue = progressValue;
    //中间 Label 数值变动
    NSNumber *valueNum = [NSNumber numberWithFloat:self.value];
    
}

//隐藏值为0的贝塞尔曲线
- (void)hideTheZeroValueBeziel {
    if (self.value == 0) {
        _progressLayer.hidden = YES;
    }
}



- (void)setValue:(CGFloat)value {
    _value = value;
    [self startAnimation];
}

- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [self colorWithRGBHex:hexNum];
}

- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


@end
