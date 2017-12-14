//
//  AADrawLineWithAnimationView.m
//  AAProgressBarDemo
//
//  Created by AnAn on 2017/12/15.
//  Copyright © 2017年 An An. All rights reserved.
//

#import "AADrawLineWithAnimationView.h"

//其它动画时长
static CGFloat animationDuration = 1.5;
//位移动画时长
static CGFloat positionDuration = 0.3f;

//线条颜色
#define LineColor [UIColor colorWithRed:12/255.0 green:190/255.0 blue:6/255.0 alpha:1]
@interface AADrawLineWithAnimationView() {
    //是否正在执行动画
    BOOL _isAnimating;
    
    //左侧竖条
    CAShapeLayer *_leftLineLayer;
    
    //右侧竖条
    CAShapeLayer *_rightLineLayer;
    
    
    CAShapeLayer *_oneLineLayer;
    CAShapeLayer *_twoLineLayer;
    CAShapeLayer *_threeLineLayer;
    
}
@end

@implementation AADrawLineWithAnimationView


- (instancetype)init {
    self = [super init];
    if (self) {
  
    }
    return self;
}

- (void)setUpTheUIViews {
//    [self addLeftLineLayer];
//    [self addRightLineLayer];
    
//    [self addOneLineLayer];
//    [self addTwoLineLayer];
//    [self addThreeLineLayer];
}

/**
 添加左侧竖线层
 */
- (void)addLeftLineLayer {
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(a*0.2,0)];
    [path addLineToPoint:CGPointMake(a*0.2,a)];
    
    _leftLineLayer = [CAShapeLayer layer];
    _leftLineLayer.path = path.CGPath;
    _leftLineLayer.fillColor = [UIColor clearColor].CGColor;
    _leftLineLayer.strokeColor = LineColor.CGColor;
    _leftLineLayer.lineWidth = [self lineWidth];
    _leftLineLayer.lineCap = kCALineCapRound;
    _leftLineLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:_leftLineLayer];
    
    //开始左侧线条动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:_leftLineLayer name:nil duration:animationDuration/2 delegate:nil];
}

/**
 添加右侧竖线层
 */
- (void)addRightLineLayer {
    
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(a*0.8,a)];
    [path addLineToPoint:CGPointMake(a*0.8,0)];
    
    
    _rightLineLayer = [CAShapeLayer layer];
    _rightLineLayer.path = path.CGPath;
    _rightLineLayer.fillColor = [UIColor clearColor].CGColor;
    _rightLineLayer.strokeColor = LineColor.CGColor;
    _rightLineLayer.lineWidth = [self lineWidth];
    _rightLineLayer.lineCap = kCALineCapRound;
    _rightLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLineLayer];
    
    //开始左侧线条动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:_rightLineLayer name:nil duration:animationDuration/2 delegate:nil];
}


- (void)addOneLineLayer {
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(a*0.5,a*0)];
    [path addLineToPoint:CGPointMake(a*0.5,a*0.75)];
    
    
    _oneLineLayer = [CAShapeLayer layer];
    _oneLineLayer.path = path.CGPath;
    _oneLineLayer.fillColor = [UIColor clearColor].CGColor;
    _oneLineLayer.strokeColor = LineColor.CGColor;
    _oneLineLayer.lineWidth = [self lineWidth];
    _oneLineLayer.lineCap = kCALineCapRound;
    _oneLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_oneLineLayer];
    
    //开始左侧线条动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:_oneLineLayer name:nil duration:animationDuration/2 delegate:nil];
    
}

- (void)addTwoLineLayer {
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(a*0.2,a*0.5)];
    [path addLineToPoint:CGPointMake(a*0.5,a*0.75)];
    [path addLineToPoint:CGPointMake(a*0.8,a*0.5)];
    
    
    
    
    _twoLineLayer = [CAShapeLayer layer];
    _twoLineLayer.path = path.CGPath;
    _twoLineLayer.fillColor = [UIColor clearColor].CGColor;
    _twoLineLayer.strokeColor = LineColor.CGColor;
    _twoLineLayer.lineWidth = [self lineWidth];
    _twoLineLayer.lineCap = kCALineCapRound;
    _twoLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_twoLineLayer];
    
    //开始左侧线条动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:_twoLineLayer name:nil duration:animationDuration/2 delegate:nil];
}

- (void)addThreeLineLayer {
    CGFloat a = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(a*0.01,a*0.7)];
    [path addLineToPoint:CGPointMake(a*0.01,a*1.0)];
    [path addLineToPoint:CGPointMake(a*0.99,a*1.0)];
    [path addLineToPoint:CGPointMake(a*0.99,a*0.7)];

    
    

    _threeLineLayer = [CAShapeLayer layer];
    _threeLineLayer.path = path.CGPath;
    _threeLineLayer.fillColor = [UIColor clearColor].CGColor;
    _threeLineLayer.strokeColor = LineColor.CGColor;
    _threeLineLayer.lineWidth = [self lineWidth];
    _threeLineLayer.lineCap = kCALineCapRound;
    _threeLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_threeLineLayer];
    
    //开始左侧线条动画
    [self strokeEndAnimationFrom:0 to:1 onLayer:_threeLineLayer name:nil duration:animationDuration/2 delegate:nil];
}




/**
 通用执行strokeEnd动画
 */
- (CABasicAnimation *)strokeEndAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue onLayer:(CALayer *)layer name:(NSString*)animationName duration:(CGFloat)duration delegate:(id)delegate {
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = duration;
    strokeEndAnimation.fromValue = @(fromValue);
    strokeEndAnimation.toValue = @(toValue);
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    [strokeEndAnimation setValue:animationName forKey:@"animationName"];
    strokeEndAnimation.delegate = delegate;
    [layer addAnimation:strokeEndAnimation forKey:nil];
    return strokeEndAnimation;
}

#pragma mark -
#pragma mark 其他方法
//线条宽度，根据按钮的宽度按比例设置
- (CGFloat)lineWidth {
    return 3;
    return self.bounds.size.width * 0.2;
}

- (void)setIsDownloading:(BOOL)isDownloading {
    _isAnimating = isDownloading;
    if (isDownloading == NO) {
        [self addOneLineLayer];
        [self addTwoLineLayer];
        [self addThreeLineLayer];
        
        [_leftLineLayer removeFromSuperlayer];
        [_rightLineLayer removeFromSuperlayer];
        
    } else {
            [self addLeftLineLayer];
            [self addRightLineLayer];
        [_oneLineLayer removeFromSuperlayer];
        [_twoLineLayer removeFromSuperlayer];
        [_threeLineLayer removeFromSuperlayer];
    }
}

@end
