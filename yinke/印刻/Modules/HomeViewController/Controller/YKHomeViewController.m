//
//  YKHomeViewController.m
//  印刻
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YKHomeViewController.h"
#import "YKPopularViewController.h"     // 热门
#import "YKHomeCollectionViewCell.h"    // 关注 Cell
#import "YKPopularCollectionViewCell.h" // 热门 Cell
#import "YKLatestCollectionViewCell.h"  // 最新 Cell
#import "YKLatestViewController.h"      // 最新
#import "YKAttentionViewController.h"   // 关注
#import "YKChannelModel.h"              // M
#import "YKChannelLabel.h"              // label
#import "YKTabbarBtn.h"                 // btn
#import "ScrollViewChangesNavigationBarDelegate.h"  //滚动隐藏导航栏

#define TITLEVIEW_WIDTH 200
#define AppColor [UIColor colorWithRed:0.00392 green:0.576 blue:0.871 alpha:1]
static NSString * const reuseOneID  = @"YKHomeCollectionViewCell";
static NSString * const popularID  = @"YKPopularCollectionViewCell";
static NSString * const latestID  = @"YKLatestCollectionViewCell";

@interface YKHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, ScrollViewChangesNavigationBarDelegate>

/** 频道数据模型 */
@property (nonatomic, strong) NSArray *channelList;

/** 按钮状态  */
@property (nonatomic, assign) BOOL btn;

/** 频道列表 */
@property (nonatomic, strong) UIScrollView *smallScrollView;

/** 当前要展示频道list */
@property (nonatomic, strong) NSMutableArray *list_now;

/** 视图 */
@property (nonatomic, strong) UICollectionView *bigCollectionView;

/** 下划线 */
@property (nonatomic, strong) UIView *underline;


@end

@implementation YKHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self hideNavImg];
    
    [self setUpNavigtionController];
    
    [self setHomeView];
}


//去nav黑线
-(void)hideNavImg
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

//设置导航栏
-(void)setUpNavigtionController
{
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"global_tittle_bg"]forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(145, 225, 211);
    
    /** nav标题View */
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TITLEVIEW_WIDTH, 40)];
    [titleView setBackgroundColor:[UIColor clearColor]];

    
    //菜单栏
    _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, TITLEVIEW_WIDTH-3, 40)];
    _smallScrollView.backgroundColor = [UIColor clearColor];
    _smallScrollView.showsHorizontalScrollIndicator = NO;
    // 设置频道
    _list_now = self.channelList.mutableCopy;
    [self setupChannelLabel];
    // 设置下划线
    [_smallScrollView addSubview:({
        if ([self getLabelArrayFromSubviews].count <= 0) {
            return;
        }
        YKChannelLabel *firstLabel = [self getLabelArrayFromSubviews][0];
        firstLabel.textColor = AppColor;
        // smallScrollView高度44，取下面4个点的高度为下划线的高度。
        _underline = [[UIView alloc] initWithFrame:CGRectMake(0, 39, firstLabel.textWidth, 1)];
        _underline.centerX = firstLabel.centerX;
        _underline.backgroundColor = AppColor;
        _underline;
    })];
    
    [titleView addSubview:_smallScrollView];
    
    self.navigationItem.titleView = titleView;
    
    /** Left 按钮 */
    YKTabbarBtn *leftBtn = [[YKTabbarBtn alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    leftBtn.backgroundColor = [UIColor blackColor];
    [leftBtn setYKTabbarBtnImageSize:CGSizeMake(40/5*2, 40/5*2) AndDirection:@"left"];
    [leftBtn setYKImage:[UIImage imageNamed:@"global_search"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    /** right 按钮 */
    YKTabbarBtn *rightBtn = [[YKTabbarBtn alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    rightBtn.backgroundColor = [UIColor blackColor];
    [rightBtn setYKTabbarBtnImageSize:CGSizeMake(40/5*2, 40/5*2) AndDirection:@"right"];
    [rightBtn setYKImage:[UIImage imageNamed:@"me_new_sixin_live"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
}

/** 导航栏搜索 */
-(void)leftBtnClick
{
    NSLog(@"导航栏搜索");
}
/** 导航栏消息 */
-(void)rightBtnClick
{
    NSLog(@"导航栏消息");
}

-(void)setHomeView
{
    // 高度 = 屏幕高度 - 导航栏高度64 - 频道视图高度44
//    CGFloat h = SCREEN_HEIGHT - 64;
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //视图
    _bigCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    _bigCollectionView.backgroundColor = [UIColor whiteColor];
    _bigCollectionView.delegate = self;
    _bigCollectionView.dataSource = self;
    [_bigCollectionView registerClass:[YKHomeCollectionViewCell class] forCellWithReuseIdentifier:reuseOneID];
    [_bigCollectionView registerClass:[YKPopularCollectionViewCell class] forCellWithReuseIdentifier:popularID];
    [_bigCollectionView registerClass:[YKLatestCollectionViewCell class] forCellWithReuseIdentifier:latestID];
    //弹簧
    _bigCollectionView.bounces = NO;
    
    //滚动条
    _bigCollectionView.showsVerticalScrollIndicator = NO;
    _bigCollectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置cell的大小和细节
    flowLayout.itemSize = _bigCollectionView.bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    _bigCollectionView.pagingEnabled = YES;
    _bigCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bigCollectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - getter
- (NSArray *)channelList
{
    if (_channelList == nil) {
        _channelList = [YKChannelModel channels];
    }
    return _channelList;
}




/** 设置频道标题 */
- (void)setupChannelLabel
{
    CGFloat margin = 20.0;
    CGFloat x = 8;
    CGFloat h = _smallScrollView.bounds.size.height;
    int i = 0;
    for (YKChannelModel *channel in _list_now) {
        YKChannelLabel *label = [YKChannelLabel channelLabelWithTitle:channel.tname];
        label.textColor = [UIColor whiteColor];
        label.frame = CGRectMake(x, 0, label.width + margin, h);
        [_smallScrollView addSubview:label];
        
        x += label.bounds.size.width;
        label.tag = i++;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    _smallScrollView.contentSize = CGSizeMake(x + margin, 0);
}

/** 频道Label点击事件 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    YKChannelLabel *label = (YKChannelLabel *)recognizer.view;
    // 点击label后，让bigCollectionView滚到对应位置。
    [_bigCollectionView setContentOffset:CGPointMake(label.tag * _bigCollectionView.frame.size.width, 0)];
    // 重新调用一下滚定停止方法，让label的着色和下划线到正确的位置。
    [self scrollViewDidEndScrollingAnimation:self.bigCollectionView];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _list_now.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UIColor *backgroundColor = [self suijiColor];
//    cell.backgroundColor = backgroundColor;
//    DLog(@"indexPath %ld",(long)indexPath.row);

    switch (indexPath.row) {
        case 0:
        {
            YKHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseOneID forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[YKHomeCollectionViewCell alloc] init];
            }

            cell.delegate = self;
            
            YKChannelModel *channel = _list_now[indexPath.row];
            
            [cell setViewControllerChnnelModel:(YKChannelModel *)channel];
            
//            [self addChildViewController:cell.ykHomeVC];
            
             return cell;
            break;
        }
            
        case 1:
        {
            YKPopularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:popularID forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[YKPopularCollectionViewCell alloc] init];
            }

            cell.delegate = self;
            
            YKChannelModel *channel = _list_now[indexPath.row];
            
            [cell setViewControllerChnnelModel:(YKChannelModel *)channel];
            
//            [self addChildViewController:cell.ykHomeVC];
            
             return cell;
            break;
        }
        case 2:
        {
            YKLatestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:latestID forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[YKLatestCollectionViewCell alloc] init];
            }

            cell.delegate = self;
            
            YKChannelModel *channel = _list_now[indexPath.row];
            
            [cell setViewControllerChnnelModel:(YKChannelModel *)channel];
            
//            [self addChildViewController:cell.ykHomeVC];
            
             return cell;
            break;
        }
            
            
        default:
            return nil;
            break;
    }
    
    
    


    
   
}

//随机色
-(UIColor *)suijiColor
{
    CGFloat hue        = ( arc4random() % 256 / 256.0 );        //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

/** 获取smallScrollView中所有的YKChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (YKChannelLabel *label in _smallScrollView.subviews) {
        if ([label isKindOfClass:[YKChannelLabel class]]) {
            [arrayM addObject:label];
        }
    }
    return arrayM.copy;
}


#pragma mark - UICollectionViewDelegate

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (value < 0) {return;} // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
    
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    if (rightIndex >= [self getLabelArrayFromSubviews].count) {  // 防止滑到最右，再滑，数组越界，从而崩溃
        rightIndex = [self getLabelArrayFromSubviews].count - 1;
    }
    
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft  = 1 - scaleRight;
    
    YKChannelLabel *labelLeft  = [self getLabelArrayFromSubviews][leftIndex];
    YKChannelLabel *labelRight = [self getLabelArrayFromSubviews][rightIndex];
    
    //滑动时改变颜色
//    labelLeft.scale  = scaleLeft;
//    labelRight.scale = scaleRight;
    
    //	 NSLog(@"value = %f leftIndex = %zd, rightIndex = %zd", value, leftIndex, rightIndex);
    //	 NSLog(@"左%f 右%f", scaleLeft, scaleRight);
    //	 NSLog(@"左：%@ 右：%@", labelLeft.text, labelRight.text);
    
    // 点击label会调用此方法1次，会导致【scrollViewDidEndScrollingAnimation】方法中的动画失效，这时直接return。
    if (scaleLeft == 1 && scaleRight == 0) {
        return;
    }
    
    // 下划线动态跟随滚动：马勒戈壁的可算让我算出来了
    _underline.centerX = labelLeft.centerX   + (labelRight.centerX   - labelLeft.centerX)   * scaleRight;
    _underline.width   = labelLeft.textWidth + (labelRight.textWidth - labelLeft.textWidth) * scaleRight;
}

/** 手指滑动BigCollectionView，滑动结束后调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.bigCollectionView]) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

/** 手指点击smallScrollView */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigCollectionView.width;
    
    // 滚动标题栏到中间位置
    YKChannelLabel *titleLable = [self getLabelArrayFromSubviews][index];
    CGFloat offsetx   =  titleLable.center.x - _smallScrollView.width * 0.5;
    CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
    
    // 在最左和最右时，标签没必要滚动到中间位置。
    if (offsetx < 0)		 {offsetx = 0;}
    if (offsetx > offsetMax) {offsetx = offsetMax;}
    [_smallScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    
    // 先把之前着色的去色：（快速滑动会导致有些文字颜色深浅不一，点击label会导致之前的标题不变回黑色）
    for (YKChannelLabel *label in [self getLabelArrayFromSubviews]) {
        label.textColor = [UIColor whiteColor];
    }
    
    // 下划线滚动并着色
    [UIView animateWithDuration:0.5 animations:^{
        _underline.width = titleLable.textWidth;
        _underline.centerX = titleLable.centerX;
        titleLable.textColor = AppColor;
    }];
}

#pragma mark - ScrollViewChangesNavigationBarDelegate

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar lt_setTranslationY:(-64 * progress)];
}

@end
