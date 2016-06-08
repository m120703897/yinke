//
//  YKChannelModel.m
//  印刻
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKChannelModel.h"

@implementation YKChannelModel

+ (instancetype)channelWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    NSArray *array = @[@"tname", @"tid"];
    [array enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        if (dict[key]) {
            [obj setValue:dict[key] forKey:key];
        }
    }];
    return obj;
}

+ (NSArray *)channels
{
    // 频道列表没从网上获取，直接用了网易新闻bundle里的这个文件。
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//    NSArray *array = dict[@"tList"];
//    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
//    
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [arrayM addObject:[self channelWithDict:obj]];
//    }];
//    
//    return [arrayM sortedArrayUsingComparator:^NSComparisonResult(YKChannelModel *obj1, YKChannelModel *obj2) {
//         //NSString 比较
//        return [obj1.tid compare:obj2.tid];
//    }];
    
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *array = [dict objectForKey:@"tList"];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dicData in array) {
        [arrayM addObject:[self channelWithDict:dicData]];
    }
    return arrayM;
    
}

- (void)setTid:(NSString *)tid {
    _tid = tid.copy;
    _urlString = [NSString stringWithFormat:@"article/headline/%@/0-20.html", tid];
}


- (NSString *)description {
    NSDictionary *dict = [self dictionaryWithValuesForKeys:@[@"tname", @"tid"]];
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, dict];
}


@end
