//
//  YKAttentionViewController.m
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKAttentionViewController.h"
#import "YKPopularTableViewCell.h"

@interface YKAttentionViewController ()<UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UITableView *attentionTabView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) float tabOffsetY;
@property (nonatomic, assign) float tabOffsetRange;
@property (nonatomic, assign) float progressY;


@end

@implementation YKAttentionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    self.view.backgroundColor = [UIColor purpleColor];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    _label.backgroundColor = [UIColor yellowColor];
    
    _label.center = self.view.center;
    
    _label.textAlignment = NSTextAlignmentCenter;
    [_label setTextColor:[UIColor blackColor]];
    [_label setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:30]];
    [self.view addSubview:_label];
    */
    
    _progressY = 0.0;
    _tabOffsetY = 0.0;
    _tabOffsetRange = 0.0;
    
    [self initWithAttentionTabView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

//ID
-(void)setTid:(NSString *)tid
{
    DLog(@"TID = %@",tid);
//    [_label setText:tid];
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
    
    
    if (scrollView.contentOffset.y == scrollView.contentSize.height - self.attentionTabView.frame.size.height) {
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
                self.attentionTabView.frame = CGRectMake(0, 64-offsetY, SCREEN_WIDTH, SCREEN_HEIGHT);
            }
            else
            {
                if (offsetY - _tabOffsetRange < 0 && _tabOffsetRange < 20)
                {
                    [self setNavigationBarTransformProgress:(0)];
                    self.attentionTabView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
                }
                else
                {
                    
                    self.attentionTabView.frame = CGRectMake(0, 64-offsetY, SCREEN_WIDTH, SCREEN_HEIGHT);
                    
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
                self.attentionTabView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                
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
        self.attentionTabView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        [APP_DELEGATE showTabbarView];
    }
}

//收回导航栏
- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.delegate setNavigationBarTransform:progress];
}


#pragma mark - TableView

-(void)initWithAttentionTabView
{
    _dataSource = [NSMutableArray array];
    self.attentionTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                         style:UITableViewStyleGrouped];
    self.attentionTabView.dataSource = self;
    self.attentionTabView.delegate = self;
    [self.view addSubview:self.attentionTabView];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count+2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKPopularTableViewCell *cell = (YKPopularTableViewCell *)[self tableView:self.attentionTabView cellForRowAtIndexPath:indexPath];
    return cell.CellH;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 44)];
    
    headView.backgroundColor = [UIColor purpleColor];
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

@end
