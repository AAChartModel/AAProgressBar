//
//  AADownLoadButton.h
//  AAProgressBarDemo
//
//  Created by AnAn on 2017/12/13.
//  Copyright © 2017年 An An. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AADownLoadButtonDidSelectedDelegate <NSObject>
- (void)AADownLoadButtonDidSelectedWithWorkingState:(BOOL )isWorking;
@end

typedef void(^AADownLoadButtonDidSelected)(BOOL isWorking);

@interface AADownLoadButton : UIView
@property (nonatomic, assign) CGFloat   progressValue;
@property (nonatomic, assign) BOOL isWorking;
@property (nonatomic, weak) id<AADownLoadButtonDidSelectedDelegate> didSelectedDelegate;
@property (nonatomic, copy)   AADownLoadButtonDidSelected didSelectedBlock;
@end
