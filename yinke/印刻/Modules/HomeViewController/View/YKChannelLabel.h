//
//  YKChannelLabel.h
//  印刻
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKChannelLabel : UILabel

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat textWidth;

+ (instancetype)channelLabelWithTitle:(NSString *)title;

@end
