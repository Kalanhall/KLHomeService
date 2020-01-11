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
    
    self.navigationBar.backgroundView.image = [UIImage kl_imageWithImageName:@"jd02" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.searchbackgroundView.image = [UIImage kl_imageWithImageName:@"jd03" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.searchBarLeftView.image = [UIImage kl_imageWithImageName:@"jd06" inBundle:[NSBundle bundleForClass:self.class]];
    self.navigationBar.searchBarRightView.image = [UIImage kl_imageWithImageName:@"jd07" inBundle:[NSBundle bundleForClass:self.class]];
    [self.view addSubview:self.navigationBar];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.description];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationBar scaleBarWithRightSpace:80 refreshHeight:0];
}

@end
