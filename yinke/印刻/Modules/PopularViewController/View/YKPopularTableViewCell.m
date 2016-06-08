//
//  YKPopularTableViewCell.m
//  印刻
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKPopularTableViewCell.h"
@import CoreText;
//#import "XPQLabel.h"                //富文本label

@interface YKPopularTableViewCell ()

//头像
@property (nonatomic, strong) UIImageView *headImgView;
//性别
@property (nonatomic, strong) UIImageView *seximgView;
//昵称
@property (nonatomic, strong) UILabel *nickNameLbl;
//地址
@property (nonatomic, strong) UIImageView *addressImgView;
@property (nonatomic, strong) UILabel *addressLabel;
//观看数
@property (nonatomic, strong) UILabel *watchNumberLbl;
//直播截图
@property (nonatomic, strong) UIImageView *liveImgView;
//当前状态
@property (nonatomic, strong) UIImageView *statuImgView;
//标签
@property (nonatomic, strong) UILabel *labelLbl;


@end

@implementation YKPopularTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _CellH = 0.0;
        
        self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        
        self.headImgView.backgroundColor = [UIColor greenColor];
        self.headImgView.layer.cornerRadius = self.headImgView.frame.size.height/2;
        self.headImgView.layer.masksToBounds = YES;
        self.headImgView.layer.borderColor = [UIColor purpleColor].CGColor;
        self.headImgView.layer.borderWidth = 2.0;
        
        [self.contentView addSubview:self.headImgView];
        
        
        
        
        self.seximgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)-13,
                                                                        CGRectGetMaxY(self.headImgView.frame)-18,
                                                                        18,
                                                                        18)];

//        self.seximgView.backgroundColor = [UIColor blueColor];
        self.seximgView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.seximgView.layer.borderWidth = 1.0;
        self.seximgView.layer.cornerRadius = 18/2;
        self.seximgView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.seximgView];
        
        
        
        self.nickNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_seximgView.frame)+5,
                                                                     5,
                                                                     100,
                                                                     50/2)];
//        self.nickNameLbl.text = @"昵称";
        self.nickNameLbl.textColor = [UIColor blackColor];
        self.nickNameLbl.font = [UIFont fontWithName:@"" size:15];
        
        [self.contentView addSubview:self.nickNameLbl];
        
        
        
        self.addressImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_seximgView.frame)+5,
                                                                           CGRectGetMaxY(self.nickNameLbl.frame)+5,
                                                                           10,
                                                                            12)];
        [self.addressImgView setImage:[UIImage imageNamed:@"2.0_live_map"]];
        [self.contentView addSubview:self.addressImgView];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_addressImgView.frame)+5,
                                                                      CGRectGetMaxY(self.nickNameLbl.frame)+5,
                                                                      100,
                                                                      12)];
        
//        self.addressLabel.text = @"地址";
        self.addressLabel.textColor = [UIColor lightGrayColor];
//        self.addressLabel.font = [UIFont fontWithName:@"" size:8];
        [self.addressLabel setFont:[UIFont systemFontOfSize:13]];
        
        [self.contentView addSubview:self.addressLabel];
        
        
        
        
        self.watchNumberLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100-10,
                                                                        CGRectGetMaxY(self.headImgView.frame)/2,
                                                                        100,
                                                                        CGRectGetMaxY(self.headImgView.frame)/2)];
//        self.watchNumberLbl.text = @"100再看";
        [self.watchNumberLbl setTextAlignment:NSTextAlignmentRight];
//        self.watchNumberLbl.textColor = [UIColor lightGrayColor];
//        self.watchNumberLbl.font = [UIFont fontWithName:@"" size:12];

        [self.watchNumberLbl setFont:[UIFont systemFontOfSize:10]];
        
        [self.contentView addSubview:self.watchNumberLbl];
        
        
        
        self.liveImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headImgView.frame)+5, SCREEN_WIDTH, SCREEN_WIDTH)];
//        self.liveImgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.liveImgView];
        
        //状态
        self.statuImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-50, 10, 50, 20)];
        
        [self.liveImgView addSubview:self.statuImgView];
        
        
        
        self.labelLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveImgView.frame)+10, SCREEN_WIDTH-20, 30)];
//        self.labelLbl.text = @"#标签";
        self.labelLbl.textColor = [UIColor purpleColor];
        self.labelLbl.font = [UIFont fontWithName:@"" size:15];
        [self.contentView addSubview:self.labelLbl];
        
       
        _CellH = CGRectGetMaxY(self.labelLbl.frame)+10;
        
    }
    return self;
}



//头像
-(void)setHeadPortraitStr:(NSString *)headPortraitStr
{
    NSURL *headUrl = [NSURL URLWithString:headPortraitStr];
    [self.headImgView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@""]];
}

//性别
-(void)setSexStr:(NSString *)sexStr
{
//    NSURL *sexUrl = [NSURL URLWithString:sexStr];
    [self.seximgView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:sexStr]];
}

//昵称
-(void)setNickNameStr:(NSString *)nickNameStr
{
    self.nickNameLbl.text = nickNameStr;
}

//地址
-(void)setAddressStr:(NSString *)addressStr
{
    self.addressLabel.text = addressStr;
}

//观看数
-(void)setWatchNumberStr:(NSString *)watchNumberStr
{
    NSString *numberStr = [NSString stringWithFormat:@"%@ 在看",watchNumberStr];
    
    NSUInteger watchLengtch = watchNumberStr.length;
    
    //设置富文本
    NSMutableAttributedString *attriString2 = [[NSMutableAttributedString alloc] initWithString:numberStr];
    
    [attriString2 addAttribute:(NSString *)NSForegroundColorAttributeName
                         value:(id)[UIColor purpleColor].CGColor
                         range:NSMakeRange(0, watchLengtch)];
    [attriString2 addAttribute:(NSString *)NSForegroundColorAttributeName
                        value:(id)[UIColor lightGrayColor].CGColor
                        range:NSMakeRange(watchLengtch+1, 2)];
    
    [attriString2 addAttribute:(NSString *)NSFontAttributeName
                         value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:0].fontName, 20, NULL))
                         range:NSMakeRange(0, watchLengtch)];
    
    _watchNumberLbl.attributedText = attriString2;
}

//直播截图
-(void)setLiveImgStr:(NSString *)liveImgStr
{
    NSURL *liveUrl = [NSURL URLWithString:liveImgStr];
    [self.liveImgView sd_setImageWithURL:liveUrl placeholderImage:[UIImage imageNamed:@""]];
    _CellH = CGRectGetMaxY(self.liveImgView.frame)+10;
}

//直播状态
-(void)setLiveStatuStr:(NSString *)liveStatuStr
{
    if ([liveStatuStr isEqualToString:@"预告"]) {
        //预告  live_tag_announce
        [self.statuImgView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"live_tag_announce"]];
    }else if ([liveStatuStr isEqualToString:@"直播"]) {
        //直播  live_tag_live
        [self.statuImgView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"live_tag_live"]];
    }else if ([liveStatuStr isEqualToString:@"回放"]) {
        //回放  live_tag_replay
        [self.statuImgView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"live_tag_replay"]];
    }else{
        DLog(@"未知直播状态");
    }
}

//标签
-(void)setLabelStr:(NSString *)labelStr
{
    
    if (labelStr == nil || [labelStr isEqualToString:@""]) {
        
        [self.labelLbl setHidden:YES];
    }else{
        [self.labelLbl setHidden:NO];
        _CellH = CGRectGetMaxY(self.labelLbl.frame)+10;
        self.labelLbl.text = labelStr;
    }
    
}

@end
