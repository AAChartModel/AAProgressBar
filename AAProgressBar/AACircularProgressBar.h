//
//  AACircularProgressBar.h
//  AAProgressBarDemo
//
//  Created by An An on 2017/8/29.
//  Copyright © 2017年 An An. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AACircularProgressBar : UIView

@property (nonatomic,assign) CGFloat   value;

@property (nonatomic,assign) CGFloat   maxValue;

@property (nonatomic,copy)   NSString  *unitString;

@end
