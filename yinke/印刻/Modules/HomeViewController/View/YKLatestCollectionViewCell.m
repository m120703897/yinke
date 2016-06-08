//
//  YKLatestCollectionViewCell.m
//  印刻
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKLatestCollectionViewCell.h"
#import "YKLatestViewController.h"      // 最新
#import "YKChannelModel.h"              // M


@interface YKLatestCollectionViewCell ()<YKLatestViewControllerDelegate>

@property (nonatomic, strong) YKLatestViewController *LatestVC;

@end
@implementation YKLatestCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _LatestVC = [[YKLatestViewController alloc]init];
        
        self.ykHomeVC = _LatestVC;
        
        self.LatestVC.delegate = self;
        
        [self.contentView addSubview:_LatestVC.view];
    }
    return self;
}


-(void)setViewControllerChnnelModel:(YKChannelModel *)channelDO
{
    // 最新
    _LatestVC.tid = channelDO.tid;
    
    
}

//收回导航栏
- (void)setNavigationBarTransform:(CGFloat)progress
{
    [self.delegate setNavigationBarTransformProgress:progress];
}

@end
