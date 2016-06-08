//
//  YKHomeCollectionViewCell.m
//  印刻
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKHomeCollectionViewCell.h"
#import "YKAttentionViewController.h"   // 关注
#import "YKChannelModel.h"              // M



#pragma mark -  YKHomeCollectionViewCell

@interface YKHomeCollectionViewCell ()<YKAttentionViewControllerDelegate>

@property (nonatomic, strong) YKAttentionViewController *attentionVC;

@end

@implementation YKHomeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _attentionVC = [[YKAttentionViewController alloc]init];
        
        self.ykHomeVC = _attentionVC;
        
        self.attentionVC.delegate = self;
        
        [self.contentView addSubview:_attentionVC.view];
    }
    return self;
}

-(void)setViewControllerChnnelModel:(YKChannelModel *)channelDO
{
    // 关注
    _attentionVC.tid = channelDO.tid;
    
}

//收回导航栏
- (void)setNavigationBarTransform:(CGFloat)progress
{
    [self.delegate setNavigationBarTransformProgress:progress];
}

@end








