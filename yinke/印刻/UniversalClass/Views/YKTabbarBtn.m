//
//  YKTabbarBtn.m
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKTabbarBtn.h"


@interface YKTabbarBtn ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIImage *hightlightedImg;

@property (nonatomic, strong) UIImage *nomalImg;

@end
@implementation YKTabbarBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/3, frame.size.width/3)];
        
        self.imgView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        
//        self.imgView.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.imgView];
        
    }
    return self;
}

-(void)setYKTabbarBtnImageSize:(CGSize)size AndDirection:(NSString *)direction
{
    self.imgView.frame = CGRectMake(0, 0, size.width, size.height);
    if ([direction isEqualToString:@"left"])
    {
        self.imgView.center = CGPointMake(self.imgView.center.x, self.center.y);
    }
    else if ([direction isEqualToString:@"right"])
    {
        self.imgView.frame = CGRectMake(self.frame.size.width-self.imgView.frame.size.width, 0, size.width, size.height);
        self.imgView.center = CGPointMake(self.imgView.center.x, self.center.y);
    }
    else
    {
        self.imgView.center = CGPointMake(self.frame.size.width/2, self.center.y);
    }
    
}

-(void)setYkSelected:(BOOL)ykSelected
{
    if (ykSelected) {
        [self.imgView setImage:self.hightlightedImg];
    }else{
        [self.imgView setImage:self.nomalImg];
    }
//    self.ykSelected = ykSelected;
}

-(void)setYKImage:(UIImage *)image forState:(UIControlState)state
{

    if (state == UIControlStateNormal) {
        self.nomalImg = image;
        [self.imgView setImage:self.nomalImg];
    }else{
        self.hightlightedImg = image;
    }
}

@end
