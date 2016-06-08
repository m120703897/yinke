//
//  YKTabbarBtn.h
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKTabbarBtn : UIButton

@property(nonatomic) BOOL ykSelected;

-(void)setYKImage:(UIImage *)image forState:(UIControlState)state;

-(void)setYKTabbarBtnImageSize:(CGSize)size AndDirection:(NSString *)direction;

@end
