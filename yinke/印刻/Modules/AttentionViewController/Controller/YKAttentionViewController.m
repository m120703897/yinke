//
//  YKAttentionViewController.m
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKAttentionViewController.h"

@interface YKAttentionViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation YKAttentionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    _label.backgroundColor = [UIColor yellowColor];
    
    _label.center = self.view.center;
    
    _label.textAlignment = NSTextAlignmentCenter;
    [_label setTextColor:[UIColor blackColor]];
    [_label setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:30]];
    [self.view addSubview:_label];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setTid:(NSString *)tid
{
    [_label setText:tid];
}

//收回导航栏
- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.delegate setNavigationBarTransform:progress];
}

@end
