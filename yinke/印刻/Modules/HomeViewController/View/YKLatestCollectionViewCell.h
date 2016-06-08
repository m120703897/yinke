//
//  YKLatestCollectionViewCell.h
//  印刻
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollViewChangesNavigationBarDelegate.h"

@class YKChannelModel;

@interface YKLatestCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id<ScrollViewChangesNavigationBarDelegate>delegate;

@property (nonatomic, strong) UIViewController *ykHomeVC;

-(void)setViewControllerChnnelModel:(YKChannelModel *)channelDO;

@end
