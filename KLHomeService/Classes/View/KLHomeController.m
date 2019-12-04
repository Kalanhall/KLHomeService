//
//  KLHomeController.m
//  KLHomeService
//
//  Created by Logic on 2019/11/29.
//

@import KLCategory;
@import KLCollectionViewFlowLayout;
@import Masonry;
@import KLNavigationController;
@import SDWebImage;
@import MJRefresh;

#import "KLHomeController.h"
#import "KLHomeImageCell.h"
#import "KLHomeCarouselCell.h"
#import "KLHomeImageTitleCell.h"
#import "KLDynamicNavigationBar.h"
#import "KLHomeWebController.h"

@interface KLHomeController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    KLCollectionViewBaseFlowLayoutDelegate
>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) KLDynamicNavigationBar *dynamicBar;
@property (strong, nonatomic) NSMutableArray *texts;

@end

@implementation KLHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
    self.kl_barAlpha = 0;
    self.kl_barStyle = UIBarStyleBlackOpaque;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    self.dynamicBar = [KLDynamicNavigationBar.alloc initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, Auto_Top() + 40)
                                                       scrollView:self.collectionView];
    self.dynamicBar.backgroundView.image = [UIImage kl_imageWithImageName:@"bot" inBundle:[NSBundle bundleForClass:self.class]];
    self.dynamicBar.botView.image = [UIImage kl_imageWithImageName:@"bot" inBundle:[NSBundle bundleForClass:self.class]];
    self.dynamicBar.topView.image = [UIImage kl_imageWithImageName:@"top" inBundle:[NSBundle bundleForClass:self.class]];
    [self.view addSubview:self.dynamicBar];
    
    UIButton *item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    item1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [item1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [item1 setImage:[UIImage kl_imageWithImageName:@"相机" inBundle:[NSBundle bundleForClass:self.class]] forState:UIControlStateNormal];
    UIButton *item2 = [UIButton buttonWithType:UIButtonTypeCustom];
    item2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [item2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [item2 setImage:[UIImage kl_imageWithImageName:@"消息" inBundle:[NSBundle bundleForClass:self.class]] forState:UIControlStateNormal];
    self.dynamicBar.rightViews = @[item2, item1];
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [left setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [left setImage:[UIImage kl_imageWithImageName:@"京东" inBundle:[NSBundle bundleForClass:self.class]] forState:UIControlStateNormal];
    self.dynamicBar.leftView = left;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.texts = NSMutableArray.array;
        for (int i = 0; i < 20; i ++) {
            NSString *str = [@"测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串" substringFromIndex:arc4random_uniform(30)];
            [self.texts addObject:str];
        }
        [self.collectionView reloadData];
    });
    
    __weak typeof(self) weakself = self;
    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.collectionView.mj_header endRefreshing];
        });
    }];
    
    MJRefreshGifHeader *header = (MJRefreshGifHeader *)self.collectionView.mj_header;
    header.mj_h = 40;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.textColor = UIColor.whiteColor;
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"更新中" forState:MJRefreshStateRefreshing];
    [header setTitle:@"继续下拉有惊喜" forState:MJRefreshStatePulling];
    [header setImages:nil forState:MJRefreshStateIdle];
    [header setImages:nil forState:MJRefreshStateRefreshing];
    [header setImages:nil forState:MJRefreshStatePulling];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return 7;
        case 2:
            return self.texts.count;
        default:
            return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KLHomeCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLHomeCarouselCell.description forIndexPath:indexPath];

        cell.carousel.cellForItemAtIndex = ^(KLCarouselCell * _Nonnull carouselCell, NSArray * _Nonnull images, NSInteger index) {
            [carouselCell.imageView sd_setImageWithURL:[NSURL URLWithString:images[index]]];
        };
        
        cell.carousel.didSelectedItemCell = ^(NSInteger index) {
            NSLog(@"Index - %@", @(index));
        };
        
        cell.carousel.images = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575452488231&di=c7fda10d9b50e76da0e3e376e2de586c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F012d3658de20b6a801219c77083959.jpg",
                                    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575452488231&di=c7fda10d9b50e76da0e3e376e2de586c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F012d3658de20b6a801219c77083959.jpg",
                                    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575452488231&di=c7fda10d9b50e76da0e3e376e2de586c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F012d3658de20b6a801219c77083959.jpg"];
        [cell.carousel reloadData];
        
        return cell;
    }
    else if (indexPath.section == 2) {
        KLHomeImageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLHomeImageTitleCell.description forIndexPath:indexPath];
        cell.textLabel.text = self.texts[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575452488231&di=c7fda10d9b50e76da0e3e376e2de586c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F012d3658de20b6a801219c77083959.jpg"]];
        return cell;
    }
    
    KLHomeImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLHomeImageCell.description forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575452488231&di=c7fda10d9b50e76da0e3e376e2de586c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F012d3658de20b6a801219c77083959.jpg"]];
 
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(0, Auto(150));
        case 1:
            return CGSizeMake(0, Auto(125));
        case 2: {
            CGSize size = [collectionView kl_sizeForCellWithIdentifier:KLHomeImageTitleCell.description indexPath:indexPath fixedWidth:(collectionView.frame.size.width - 10 * 2 - 1)/ 2 configuration:^(__kindof KLHomeImageTitleCell *cell) {
                cell.textLabel.text = self.texts[indexPath.row];
            }];
            return size;
        }
        default:
            return CGSizeZero;
    }
}

- (KLLayoutType)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout typeOfLayout:(NSInteger)section {
    switch (section) {
        case 2:
            return ClosedLayout;
        default:
            return PercentLayout;   // 百分比布局
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(KLCollectionViewBaseFlowLayout*)collectionViewLayout percentOfRow:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1: {
            switch (indexPath.row) {
                case 0:
                case 1:
                case 2:
                case 3:
                case 4:
                    return 1 / 2.0;
                default:
                    return 1 / 4.0;
            }
        }
        default:
            return 1.0;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section == [self numberOfSectionsInCollectionView:collectionView] - 1) {
        return UIEdgeInsetsMake(0, 10, @available(iOS 13.0, *) ? (Auto_Bottom() + 10) : 10, 10); // 底部扩展区域
    }
    
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 0, 0, 0);
        default:
            return UIEdgeInsetsMake(0, 10, 10, 10);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 2:
            return 5;
        default:
            return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 2:
            return 5;
        default:
            return 0;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(KLCollectionViewBaseFlowLayout*)collectionViewLayout columnCountOfSection:(NSInteger)section {
    switch (section) {
        case 2:
            return 2;
        default:
            return 0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.dynamicBar dynamicWithRightSpace:80 refreshHeight:self.collectionView.mj_header.mj_h];
    
    if (scrollView.contentOffset.y <= - scrollView.contentInset.top * 1.8) {
        [(MJRefreshGifHeader *)self.collectionView.mj_header setTitle:@"松手得惊喜" forState:MJRefreshStatePulling];
    } else {
        [(MJRefreshGifHeader *)self.collectionView.mj_header setTitle:@"继续下拉有惊喜" forState:MJRefreshStatePulling];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    BOOL activity = scrollView.contentOffset.y <= - scrollView.contentInset.top * 1.8;
    if (activity) {
        NSLog(@"To Activity");
        KLNavigationController *nav = [KLNavigationController.alloc initWithRootViewController:KLHomeWebController.new];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nav animated:NO completion:^{
            [self.collectionView.mj_header endRefreshing];
        }];
    }
}

// MARK: - Getter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        KLCollectionViewVerticalLayout *layout = KLCollectionViewVerticalLayout.alloc.init;
        layout.canDrag = NO;
        layout.header_suspension = NO;
        layout.delegate = self;
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:KLHomeImageCell.class forCellWithReuseIdentifier:KLHomeImageCell.description];
        [_collectionView registerClass:KLHomeCarouselCell.class forCellWithReuseIdentifier:KLHomeCarouselCell.description];
        [_collectionView registerClass:KLHomeImageTitleCell.class forCellWithReuseIdentifier:KLHomeImageTitleCell.description];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _collectionView;
}

@end
