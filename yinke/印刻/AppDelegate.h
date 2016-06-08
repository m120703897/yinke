//
//  AppDelegate.h
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//TabbarView 
@property (nonatomic, strong) YKViewController *ykVC;

//显示Tabbar 默认
- (void)showTabbarView;

//隐藏Tabbar
- (void)hideTabbarView;

@end

