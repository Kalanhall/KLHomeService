//
//  KLHomeController.m
//  KLHomeService
//
//  Created by Logic on 2019/11/29.
//

#import "KLHomeController.h"
@import Masonry;
@import KLCategory;
@import KLNavigationController;
@import MJRefresh;
#import "KLScaleNavigationBar.h"
#import "KLHomeBannerCell.h"
#import "KLHomeMenuCell.h"
#import "KLRefreshControl.h"

@interface KLHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) KLScaleNavigationBar *navigationBar;
@property (strong, nonatomic) KLRefreshControl *refresh;

@end

@implementation KLHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KLColor(0x7C0700);
    self.kl_barHidden = YES;
    self.kl_barStyle = UIBarStyleBlackOpaque;
    
    self.tableView = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.description];
    [self.tableView registerClass:KLHomeBannerCell.class forCellReuseIdentifier:KLHomeBannerCell.description];
    [self.tableView registerClass:KLHomeMenuCell.class forCellReuseIdentifier:KLHomeMenuCell.description];
    
    
    self.navigationBar = [KLScaleNavigationBar.alloc initWithFrame:CGRectZero scrollView:self.tableView];
    self.navigationBar.bannerHeight = KLAuto(140);
    self.navigationBar.activityBottomFixHeight = 90;
    // 导航栏上部背景（搜索栏以上）
    self.navigationBar.backgroundView.image = [UIImage kl_imageWithImageName:@"jd02" inBundle:[NSBundle bundleForClass:self.class]];
    // 导航栏下部背景（搜索栏）
    self.navigationBar.searchBackgroundView.image = [UIImage kl_imageWithImageName:@"jd03" inBundle:[NSBundle bundleForClass:self.class]];
    // 搜索栏左右图标
    self.navigationBar.searchBarLeftView.image = [UIImage kl_imageWithImageName:@"jd06" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.searchBarRightView.image = [UIImage kl_imageWithImageName:@"jd07" inBundle:[NSBundle bundleForClass:self.class]];
    // 轮播图底部背景
    self.navigationBar.bannerBackgroundView.image = [UIImage kl_imageWithImageName:@"jd04" inBundle:[NSBundle bundleForClass:self.class]];
    // 活动图
    self.navigationBar.activityView.image = [UIImage kl_imageWithImageName:@"jd05" inBundle:[NSBundle bundleForClass:self.class]];
    
    UIImageView *left = UIImageView.alloc.init;
    left.contentMode = UIViewContentModeLeft;
    self.navigationBar.leftView = left;
    [left setImage:[UIImage kl_imageWithImageName:@"jd01" inBundle:[NSBundle bundleForClass:self.class]]];
    
    UIButton *item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    item1.titleLabel.font = KLAutoBoldFont(8);
    [item1 setImage:[UIImage kl_imageWithImageName:@"code" inBundle:[NSBundle bundleForClass:self.class]] forState:UIControlStateNormal];
    [item1 setTitle:@"扫啊扫" forState:UIControlStateNormal];
    
    UIButton *item2 = [UIButton buttonWithType:UIButtonTypeCustom];
    item2.titleLabel.font = KLAutoBoldFont(8);
    [item2 setImage:[UIImage kl_imageWithImageName:@"msg" inBundle:[NSBundle bundleForClass:self.class]] forState:UIControlStateNormal];
    [item2 setTitle:@"消息" forState:UIControlStateNormal];
    self.navigationBar.rightViews = @[item2, item1];
    
    [self.navigationBar.rightView layoutIfNeeded];
    [item1 kl_layoutWithStyle:KLLayoutStyleImageTop margin:3];
    [item2 kl_layoutWithStyle:KLLayoutStyleImageTop margin:3];
    [self.view addSubview:self.navigationBar];
    
    __weak typeof(self) weakself = self;
    self.navigationBar.searchBarDidBeginEditing = ^{
        UIViewController *vc = UIViewController.new;
        vc.view.backgroundColor = UIColor.orangeColor;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    self.refresh = [KLRefreshControl.alloc initWithTargrt:self refreshAction:@selector(refreshcallback)];
    [self.tableView addSubview:self.refresh];
}

- (void)refreshcallback
{
    [self.refresh beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refresh endRefreshing];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        KLHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:KLHomeBannerCell.description];
        cell.carousel.images = @[@"https://m.360buyimg.com/mobilecms/s750x460_jfs/t1/97359/10/10096/130154/5e153938E68a9a279/e3adfd47810f4eb2.jpg!cr_1125x445_0_171!q70.jpg.dpg.webp", @"https://m.360buyimg.com/mobilecms/s750x460_jfs/t1/109363/40/3106/97064/5e0ed7c7E2522fc1f/dac139cbfed2b472.jpg!cr_1125x445_0_171!q70.jpg.dpg.webp", @"https://m.360buyimg.com/mobilecms/s750x460_jfs/t1/109288/29/3614/193141/5e13df88Ea17cf329/0fab704523428f89.jpg!cr_1125x445_0_171!q70.jpg.dpg.webp"];
        
        return cell;
    } else
    if (1 == indexPath.section) {
        KLHomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:KLHomeMenuCell.description];
        cell.backgroundImageView.image = [UIImage kl_imageWithImageName:@"jd08" inBundle:[NSBundle bundleForClass:self.class]];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.description];
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return self.navigationBar.bannerHeight;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationBar scaleBarWithRightSpace:80 refreshHeight:self.refresh.kl_height];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 京东的骚操作，刷新控件回弹距离，延时才能成功设置滚动距离
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.refresh.isRefreshing) {
            [self.tableView setContentOffset:(CGPoint){0, -self.tableView.contentInset.top + 20} animated:YES];
        }
    });
}

@end
