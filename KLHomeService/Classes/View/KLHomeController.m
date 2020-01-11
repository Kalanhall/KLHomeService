//
//  KLHomeController.m
//  KLHomeService
//
//  Created by Logic on 2019/11/29.
//

#import "KLHomeController.h"
@import KLConsole;
@import KLCategory;
@import KLNavigationController;
#import "KLScaleNavigationBar.h"
#import "KLHomeBannerCell.h"

@interface KLHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) KLScaleNavigationBar *navigationBar;

@end

@implementation KLHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KLColor(0xF6F6F6);
    self.kl_barHidden = YES;
    self.kl_barStyle = UIBarStyleBlackOpaque;
    
    self.tableView = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    
    self.navigationBar = [KLScaleNavigationBar.alloc initWithFrame:CGRectZero scrollView:self.tableView];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [left setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [left setImage:[UIImage kl_imageWithImageName:@"jd01" inBundle:[NSBundle bundleForClass:self.class]] forState:UIControlStateNormal];
    self.navigationBar.leftView = left;
    
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
    
    self.navigationBar.backgroundView.image = [UIImage kl_imageWithImageName:@"jd02" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.searchBackgroundView.image = [UIImage kl_imageWithImageName:@"jd03" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.bannerBackgroundView.image = [UIImage kl_imageWithImageName:@"jd04" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.activityView.image = [UIImage kl_imageWithImageName:@"jd05" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.searchBarLeftView.image = [UIImage kl_imageWithImageName:@"jd06" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.searchBarRightView.image = [UIImage kl_imageWithImageName:@"jd07" inBundle:[NSBundle bundleForClass:self.class]];
    
    __weak typeof(self) weakself = self;
    self.navigationBar.searchBarDidBeginEditing = ^{
        UIViewController *vc = UIViewController.new;
        vc.view.backgroundColor = UIColor.orangeColor;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
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
        cell.carousel.images = @[@"https://m.360buyimg.com/mobilecms/s750x460_jfs/t1/97359/10/10096/130154/5e153938E68a9a279/e3adfd47810f4eb2.jpg!cr_1125x445_0_171!q70.jpg", @"https://m.360buyimg.com/mobilecms/s750x460_jfs/t1/109363/40/3106/97064/5e0ed7c7E2522fc1f/dac139cbfed2b472.jpg!cr_1125x445_0_171!q70.jpg", @"https://m.360buyimg.com/mobilecms/s750x460_jfs/t1/109288/29/3614/193141/5e13df88Ea17cf329/0fab704523428f89.jpg!cr_1125x445_0_171!q70.jpg"];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.description];
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
    [self.navigationBar scaleBarWithRightSpace:80 refreshHeight:44];
}

@end
