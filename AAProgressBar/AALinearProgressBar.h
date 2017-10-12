//
//  AALinearProgressBar.h
//  AAProgressBarDemo
//
//  Created by An An on 2017/10/11.
//  Copyright © 2017年 An An. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AALinearProgressBar : UIView

/**
 * The value of the progress bar
 */
@property (nonatomic, assign) CGFloat value;

/**
 * The maximum possible value, used to calculate the progress (value/maxValue)  [0,∞)
 */
@property (nonatomic, assign) CGFloat maxValue;

/**
 * The track line width of the progress bar  [0,∞)
 */
@property (nonatomic, assign) CGFloat trackLineWidth;

/**
 * The progress line width of the progress bar  [0,∞)
 */
@property (nonatomic, assign) CGFloat progressLineWith;

/**
 * The color of the track line
 */
@property (nonatomic,strong) UIColor *trackLineColor;

/**
 * The color of the progress line
 */
@property (nonatomic,strong) UIColor *progressLineColor;

@end
