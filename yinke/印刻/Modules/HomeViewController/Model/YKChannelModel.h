//
//  YKChannelModel.h
//  印刻
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKChannelModel : NSObject

@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy, readonly) NSString *urlString;

+ (instancetype)channelWithDict:(NSDictionary *)dict;
+ (NSArray *)channels;

@end
