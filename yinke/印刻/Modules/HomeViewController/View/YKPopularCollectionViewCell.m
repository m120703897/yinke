//
//  YKPopularCollectionViewCell.m
//  印刻
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKPopularCollectionViewCell.h"
#import "YKChannelModel.h"
#import "YKPopularViewController.h"  //热门

@interface YKPopularCollectionViewCell ()<YKPopularViewControllerDelegate>

@property (nonatomic, strong) YKPopularViewController *popularVC;

@end

@implementation YKPopularCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _popularVC = [[YKPopularViewController alloc]init];
        
        self.ykHomeVC = _popularVC;
        
        self.popularVC.delegate = self;
        
        [self.contentView addSubview:_popularVC.view];
    }
    return self;
}


-(void)setViewControllerChnnelModel:(YKChannelModel *)channelDO
{
    // 热门
   _popularVC.tid = channelDO.tid;
    
}


- (void)setNavigationBarTransform:(CGFloat)progress
{
    [self.delegate setNavigationBarTransformProgress:progress];
}

@end
