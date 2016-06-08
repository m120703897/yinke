//
//  YKLatestViewController.h
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//  最新

#import "BaseViewController.h"

@protocol YKLatestViewControllerDelegate <NSObject>

- (void)setNavigationBarTransform:(CGFloat)progress;

@end

@interface YKLatestViewController : BaseViewController

@property (nonatomic, strong) id<YKLatestViewControllerDelegate>delegate;

@property (nonatomic, strong) NSString *tid;

@end
