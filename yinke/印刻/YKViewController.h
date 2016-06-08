//
//  YKViewController.h
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKViewController : UITabBarController

//tabbar视图
@property (nonatomic, strong) UIView *ykTabbarView;

//显示Tabbar 默认
- (void)showTabbarView;

//隐藏Tabbar
- (void)hideTabbarView;



@end
