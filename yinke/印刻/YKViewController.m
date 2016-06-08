//
//  YKViewController.m
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKViewController.h"
#import "YKHomeViewController.h"        //首页
#import "YKLiveViewController.h"        //直播
#import "YKCenterViewController.h"      //个人中心
#import "YKTabbarBtn.h"                 //btn

@interface YKViewController ()



//tabbar背景图
@property (nonatomic, strong) UIImageView *backgroundImgView;

@end

@implementation YKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewControllers];
    
}

- (void)setupViewControllers {
    
    //首页
    YKHomeViewController *homeVC = [[YKHomeViewController alloc]  init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    
    //直播
    YKLiveViewController *liveVC = [[YKLiveViewController alloc] init];
    UINavigationController *liveNav = [[UINavigationController alloc] initWithRootViewController:liveVC];
   
    
    //个人中心
    YKCenterViewController *centerVC = [[YKCenterViewController alloc] init];
    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:centerVC];

    [self setViewControllers:@[homeNav, liveNav, centerNav]];
    [self customizeTabBarForController];
}

- (void)customizeTabBarForController{
    
//    [self.tabBar setHidden:YES];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [self.tabBar setAlpha:0.0];
    
    self.ykTabbarView = [[UIView alloc] initWithFrame:self.tabBar.frame];
    self.ykTabbarView.backgroundColor = [UIColor clearColor];
    
    if (iPhone6P) {
        self.ykTabbarView.frame = CGRectMake(0, SCREEN_HEIGHT-56, SCREEN_WIDTH, 56);
    }
    
    self.backgroundImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.ykTabbarView.frame.size.width, self.ykTabbarView.frame.size.height)];
    [self.backgroundImgView setImage:[UIImage imageNamed:@"tab_bg.png"]];
    self.backgroundImgView.userInteractionEnabled = YES;
    [self.ykTabbarView addSubview:self.backgroundImgView];
    
    [self.view addSubview:self.ykTabbarView];

    
    
    //button 图片
    NSArray *array = [[NSArray alloc] initWithObjects:@"tab_live", @"tab_room", @"tab_me", nil];
    
    NSInteger count = array.count;
    
    for (int i = 0; i < array.count; i++) {
        
        YKTabbarBtn *button = [[YKTabbarBtn alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/count)*i,
                                                                        10,
                                                                        SCREEN_WIDTH/count,
                                                                        self.ykTabbarView.frame.size.height-10)];
        button.center = CGPointMake(button.center.x, (self.ykTabbarView.frame.size.height+10)/2);

        if (i == 1) {
            button.frame = CGRectMake((SCREEN_WIDTH/count)*i,
                                      10,
                                      SCREEN_WIDTH/count,
                                      self.ykTabbarView.frame.size.height-10);
            button.center = CGPointMake(button.center.x, self.ykTabbarView.frame.size.height/2);
        }
        
        NSString *imgNormal       =   [NSString stringWithFormat:@"%@",array[i]];
        NSString *imgHighlight    =   [NSString stringWithFormat:@"%@_p",array[i]];
        
        [button setYKImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
        [button setYKImage:[UIImage imageNamed:imgHighlight] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTag:i];
        
        if (i == 0)
        {
            [self buttonClick:button];
        }
        
        [self.backgroundImgView addSubview:button];
        
    }

}

-(void)buttonClick:(YKTabbarBtn *)sender
{
    if (sender.userInteractionEnabled == NO) {
        return;
    }
    
    for (YKTabbarBtn *button in _backgroundImgView.subviews) {
        button.ykSelected = NO;
        button.userInteractionEnabled = YES;
    }
    
    sender.userInteractionEnabled = NO;
    
    sender.ykSelected = YES;
    
    self.selectedIndex = sender.tag;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//显示Tabbar 默认
- (void)showTabbarView
{
    [UIView animateWithDuration:0.2 animations:^{
        if (iPhone6P) {
            self.ykTabbarView.frame = CGRectMake(0, SCREEN_HEIGHT-56, SCREEN_WIDTH, 56);
        }else{
            self.ykTabbarView.frame = CGRectMake(0,
                                                 SCREEN_HEIGHT-self.tabBar.frame.size.height,
                                                 self.tabBar.frame.size.width,
                                                 self.tabBar.frame.size.height);
        }
        [self.tabBar setHidden:NO];
    }];
}

//隐藏Tabbar
- (void)hideTabbarView
{
    [UIView animateWithDuration:0.2 animations:^{
        if (iPhone6P) {
            self.ykTabbarView.frame = CGRectMake(0,
                                                 SCREEN_HEIGHT,
                                                 SCREEN_WIDTH,
                                                 56);
        }else{
            self.ykTabbarView.frame = CGRectMake(0,
                                                 SCREEN_HEIGHT,
                                                 self.tabBar.frame.size.width,
                                                 self.tabBar.frame.size.height);
        }
        [self.tabBar setHidden:YES];
    }];
}


@end
