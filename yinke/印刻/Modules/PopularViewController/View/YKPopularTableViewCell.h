//
//  YKPopularTableViewCell.h
//  印刻
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKPopularTableViewCell : UITableViewCell

//头像
@property (nonatomic, strong) NSString *headPortraitStr;
//性别
@property (nonatomic, strong) NSString *sexStr;
//昵称
@property (nonatomic, strong) NSString *nickNameStr;
//地址
@property (nonatomic, strong) NSString *addressStr;
//观看数
@property (nonatomic, strong) NSString *watchNumberStr;
//直播截图
@property (nonatomic, strong) NSString *liveImgStr;
//直播状态
@property (nonatomic, strong) NSString *liveStatuStr;
//标签
@property (nonatomic, strong) NSString *labelStr;

@property (nonatomic, assign) float CellH;

@end
