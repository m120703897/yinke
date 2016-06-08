//
//  YKPopularViewController.h
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//  热门

#import "BaseViewController.h"

@protocol YKPopularViewControllerDelegate <NSObject>

- (void)setNavigationBarTransform:(CGFloat)progress;

@end

@interface YKPopularViewController : BaseViewController

@property (nonatomic, strong) id<YKPopularViewControllerDelegate>delegate;

@property (nonatomic, strong) NSString *tid;

@end
