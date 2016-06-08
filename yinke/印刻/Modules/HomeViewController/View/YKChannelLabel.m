//
//  YKChannelLabel.m
//  印刻
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKChannelLabel.h"

@implementation YKChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title
{
    YKChannelLabel *label = [self new];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [label sizeToFit];
    label.userInteractionEnabled = YES;
    return label;
}

- (CGFloat)textWidth
{
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width + 8; 
}


- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale*0.176 green:scale*0.722 blue:scale*0.945 alpha:1];
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, self.text];
}

@end
