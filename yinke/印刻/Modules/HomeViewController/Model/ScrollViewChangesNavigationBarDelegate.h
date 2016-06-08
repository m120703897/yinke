//
//  ScrollViewChangesNavigationBarDelegate.h
//  印刻
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScrollViewChangesNavigationBarDelegate <NSObject>

- (void)setNavigationBarTransformProgress:(CGFloat)progress;

@end
