//
//  YKAttentionViewController.h
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//  关注

#import "BaseViewController.h"


@protocol YKAttentionViewControllerDelegate <NSObject>

- (void)setNavigationBarTransform:(CGFloat)progress;

@end

@interface YKAttentionViewController : BaseViewController

@property (nonatomic, strong) id<YKAttentionViewControllerDelegate>delegate;

@property (nonatomic, strong) NSString *tid;

@end
