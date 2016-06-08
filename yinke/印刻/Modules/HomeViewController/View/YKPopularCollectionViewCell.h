//
//  YKPopularCollectionViewCell.h
//  印刻
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollViewChangesNavigationBarDelegate.h"
@class YKChannelModel;

@interface YKPopularCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIViewController *ykHomeVC;

@property (nonatomic, strong) id<ScrollViewChangesNavigationBarDelegate>delegate;

-(void)setViewControllerChnnelModel:(YKChannelModel *)channelDO;



@end