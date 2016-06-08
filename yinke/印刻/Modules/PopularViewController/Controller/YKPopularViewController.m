//
//  YKPopularViewController.m
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKPopularViewController.h"
#import "YKPopularTableViewCell.h"

#define HEADVIEW_HEIGHT (254.0/640.0)*SCREEN_WIDTH

@interface YKPopularViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

@property (strong, nonatomic) UITableView *ykTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) float progressY;

@property (nonatomic, strong) SDCycleScrollView *tabHeadScrollView;
@property (nonatomic, strong) NSMutableArray *imageUrls;

@property (nonatomic, assign) float tabOffsetY;
@property (nonatomic, assign) float tabOffsetRange;

@end

@implementation YKPopularViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _progressY = 0.0;
    _tabOffsetY = 0.0;
    _tabOffsetRange = 0.0;
    
    [self initWithPopularTabView];
    
}

-(void)initWithPopularTabView
{
    self.dataSource = [NSMutableArray array];
    self.imageUrls = [NSMutableArray array];
    
    self.ykTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.ykTableView.dataSource = self;
    self.ykTableView.delegate = self;
    [self.view addSubview:self.ykTableView];
    
    
//    [self.imageUrls addObject:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white_fe6da1ec.png"];
//    [self.imageUrls addObject:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white_fe6da1ec.png"];
//    [self.imageUrls addObject:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white_fe6da1ec.png"];
    
    [self.imageUrls addObject:@"img_1"];
    [self.imageUrls addObject:@"img_2"];
    [self.imageUrls addObject:@"img_3"];
    

    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADVIEW_HEIGHT)];
    
    _tabHeadScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADVIEW_HEIGHT) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _tabHeadScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _tabHeadScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    _tabHeadScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //当前颜色
    _tabHeadScrollView.currentPageDotColor = RGBCOLOR(145, 225, 211);
    //其他颜色
    _tabHeadScrollView.pageDotColor = RGBCOLOR(0, 0, 0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _tabHeadScrollView.imageURLStringsGroup = _imageUrls;
        _tabHeadScrollView.localizationImageNamesGroup = _imageUrls;
        
    });
    [headView addSubview:_tabHeadScrollView];
    
    self.ykTableView.tableHeaderView = headView;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//ID
-(void)setTid:(NSString *)tid
{
    DLog(@"YKPopular ID = %@",tid);
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = (scrollView.contentOffset.y);
    BOOL direction;
    
    if (offsetY > self.tabOffsetY && offsetY > 0)
    {
        DLog(@"上啦 %f",offsetY);
        direction = YES;
    }
    else
    {
        DLog(@"下啦 %f",offsetY);
        direction = NO;
    }
    
    
    if (scrollView.contentOffset.y == scrollView.contentSize.height - self.ykTableView.frame.size.height) {
        DLog(@"判断滑动到底部");
//        direction = NO;
    }
    
    self.tabOffsetY =  offsetY;
    
    
    if (offsetY > 0)
    {
        if (offsetY < 64)
        {

            if (direction == YES)
            {
                [self setNavigationBarTransformProgress:(offsetY / 64)];
                self.ykTableView.frame = CGRectMake(0, 64-offsetY, SCREEN_WIDTH, SCREEN_HEIGHT);
            }
            else
            {
                if (offsetY - _tabOffsetRange < 0 && _tabOffsetRange < 20)
                {
                    [self setNavigationBarTransformProgress:(0)];
                    self.ykTableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
                }
                else
                {
                    
                    self.ykTableView.frame = CGRectMake(0, 64-offsetY, SCREEN_WIDTH, SCREEN_HEIGHT);
                    
                    if (_tabOffsetRange > 0 )
                    {
                        
                        if (_progressY == 0)
                        {
                            [self setNavigationBarTransformProgress:(0)];
                        }
                        else
                        {
                            [self setNavigationBarTransformProgress:(offsetY / 64)];
                        }
                    }
                    else
                    {
                            [self setNavigationBarTransformProgress:(offsetY / 64)];
                        
                    }
                }
            }
        }
        else
        {
            
            if (direction == YES)
            {
                self.ykTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                
                [self setNavigationBarTransformProgress:1];
                [self.navigationController.navigationBar lt_setElementsAlpha:(0)];
                
                [APP_DELEGATE hideTabbarView];

            }
            else
            {
                _tabOffsetRange = offsetY;
                [self setNavigationBarTransformProgress:0];
                [self.navigationController.navigationBar lt_setElementsAlpha:(1.0)];
                [APP_DELEGATE showTabbarView];

            }
        }
    }
    else
    {
        [self setNavigationBarTransformProgress:0];
        self.ykTableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        [APP_DELEGATE showTabbarView];
    }
}

//隐藏导航栏
- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    _progressY = progress;
    [self.delegate setNavigationBarTransform:progress];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"YKPopularTableViewCell";
    YKPopularTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[YKPopularTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
     //头像
     cell.headPortraitStr = @"http://v1.qzone.cc/avatar/201406/09/13/26/5395456d3510f226.jpg%21200x200.jpg";
     //性别
     cell.sexStr = @"me_icn_female_def";
     //昵称
     cell.nickNameStr = @"super 悦";
     //地址
     cell.addressStr = @"山东济南";
     //观看数
     cell.watchNumberStr = @"200";
     //直播截图
     cell.liveImgStr = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1308/08/c1/24277177_1375938991124.jpg";
     //直播状态
     cell.liveStatuStr = @"直播";
     //标签
     cell.labelStr = @"";
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKPopularTableViewCell *cell = (YKPopularTableViewCell *)[self tableView:self.ykTableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%f",cell.CellH);
    return cell.CellH;
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击图片回调 %ld",(long)index);
}

@end
