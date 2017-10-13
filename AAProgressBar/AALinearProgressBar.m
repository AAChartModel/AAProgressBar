//
//  AALinearProgressBar.m
//  AAProgressBarDemo
//
//  Created by An An on 2017/10/11.
//  Copyright © 2017年 An An. All rights reserved.
//

#import "AALinearProgressBar.h"
//#define KProgressBorderWidth 2.0f
#define KProgressPadding 1.0f
//#define KProgressColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1]
#define KHWWaveFillColor [UIColor groupTableViewBackgroundColor] //填充颜色
@interface AALinearProgressBar()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) CGFloat lastValue;

@end

@implementation AALinearProgressBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpTheBasicContent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpTheBasicContent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpTheBasicContent];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
////后续考虑剔除 TrackPath,直接使用贝塞尔曲线充当路径
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 10, self.frame.size.height/2);
//    CGPathAddLineToPoint(path, NULL, self.frame.size.width-10, self.frame.size.height/2);
//
//    CGPathRef thickPath = CGPathCreateCopyByStrokingPath(path, NULL, 30, kCGLineCapButt, kCGLineJoinBevel, 0);
//    CGContextAddPath(context, thickPath);
//
//    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextSetLineWidth(context, 3);
//    CGContextDrawPath(context, kCGPathFillStroke);
//
//    CGPathRelease(thickPath);
//    CGPathRelease(path);
    
    //NO.6椭圆
     
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [KHWWaveFillColor setFill];
    [path fill];
    [path addClip];
    
    self.lastValue = 0;
    [self drawProgressLine];
    [self drawTrackLine];
}

- (void)setUpTheBasicContent {


}

- (void)drawTrackLine {
//    _trackLayer = [CAShapeLayer layer];
//    _trackLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    _trackLayer.fillColor = self.backgroundColor.CGColor;
//    _trackLayer.strokeColor = [UIColor  lightGrayColor].CGColor;
//    _trackLayer.lineWidth = 15.f;
//    _trackLayer.borderWidth = 3;
//    _trackLayer.borderColor = [UIColor purpleColor].CGColor;
//    _trackLayer.lineCap = kCALineCapRound;
//    _trackLayer.path = [self configureBezierTrackPath].CGPath;
//    [self.layer addSublayer:_trackLayer];
    
//    //边框
//    UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
//    borderView.layer.cornerRadius = self.bounds.size.height * 0.5;
//    borderView.layer.masksToBounds = YES;
//    borderView.backgroundColor = [UIColor clearColor];
//    borderView.layer.borderColor = [KProgressColor CGColor];
//    borderView.layer.borderWidth = KProgressBorderWidth;
//    [self addSubview:borderView];

}

- (void)drawProgressLine {
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    _progressLayer.fillColor = [UIColor clearColor].CGColor;//相当于self.backgroundColor.CGColor;
    _progressLayer.strokeColor = [UIColor redColor].CGColor;
    _progressLayer.lineWidth = self.bounds.size.height-KProgressPadding*2;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.path = [self configureBezierTrackPath].CGPath;
    [self.layer addSublayer:_progressLayer];
}

- (UIBezierPath *)configureBezierTrackPath {
   UIBezierPath * trackPath = [UIBezierPath bezierPath];
    trackPath.lineCapStyle  = kCGLineCapSquare;//????是啥
    trackPath.lineJoinStyle = kCGLineCapRound;
    [trackPath moveToPoint:CGPointMake(10, self.frame.size.height/2)];// 起点
    [trackPath addLineToPoint:CGPointMake(self.frame.size.width-10, self.frame.size.height/2)];

    [trackPath stroke];
    return trackPath;
}

- (void)drawEmptyBar:(CGRect)rect context:(CGContextRef)c{
    
 

}

- (void)startAnimation {
    _progressLayer.hidden = NO;
    CGFloat currentSelfValue = self.value;
    CGFloat currentSelfMaxValue = self.maxValue;
    
    if (currentSelfValue >= currentSelfMaxValue) {
        currentSelfValue = currentSelfMaxValue;//兼容实际值远超最大值的情况,避免重复绘制(我现在开始怀疑这句代码是不是真的有必要了,测试发现实际值超出最大值时,路线并不会超出给定的路径的终点)
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

}

//隐藏值为0的贝塞尔曲线
- (void)hideTheZeroValueBeziel {
    if (self.value == 0) {
        _progressLayer.hidden = YES;
    }
}

#pragma mark - setter & getter
- (void)setValue:(CGFloat)value {
    _value = value;
    [self startAnimation];
}

- (void)setTrackLineWidth:(CGFloat)trackLineWidth {
    _trackLineWidth = trackLineWidth;
    _trackLayer.lineWidth = _trackLineWidth;
}

- (void)setTrackLineColor:(UIColor *)trackLineColor {
    _trackLineColor = trackLineColor;
    _trackLayer.strokeColor = _trackLineColor.CGColor;
}

- (void)setProgressLineWith:(CGFloat)progressLineWith {
    _progressLineWith = progressLineWith;
    _progressLayer.lineWidth = _progressLineWith;
}

- (void)setProgressLineColor:(UIColor *)progressLineColor {
    _progressLineColor = progressLineColor;
    _progressLayer.strokeColor = _progressLineColor.CGColor;
}

@end
