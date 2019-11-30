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

#import "KLHomeController.h"
#import "KLHomeImageCell.h"
#import "KLHomeCarouselCell.h"
#import "KLHomeImageTitleCell.h"

@interface KLHomeController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    KLCollectionViewBaseFlowLayoutDelegate
>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *texts;

@end

@implementation KLHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.kl_barAlpha = 0;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.texts = NSMutableArray.array;
    for (int i = 0; i < 20; i ++) {
        NSString *str = [@"测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串" substringFromIndex:arc4random_uniform(30)];
        [self.texts addObject:str];
    }
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
        cell.carousel.imageURLs = @[@"", @"", @""];
        cell.carousel.didSelectedItemCell = ^(NSInteger index) {
            NSLog(@"Index - %@", @(index));
        };

        cell.carousel.cellForItemAtIndex = ^(KLCarouselCell * _Nonnull cell, NSInteger index) {
        //            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575035592451&di=bca037f79660b2bf137c3d1cfcee4c66&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2017-12-01%2F5a20c01220da2.jpg"]];
        };
        return cell;
    }
    else if (indexPath.section == 2) {
        KLHomeImageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLHomeImageTitleCell.description forIndexPath:indexPath];
        cell.textLabel.text = self.texts[indexPath.row];
        return cell;
    }
    
    KLHomeImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLHomeImageCell.description forIndexPath:indexPath];
 
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(0, Auto(200));
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
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 0, 10, 0);
        default:
            return UIEdgeInsetsMake(0, 10, 10, 10);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 2:
            return 1;
        default:
            return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 2:
            return 1;
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

// MARK: - Getter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        KLCollectionViewVerticalLayout *layout = KLCollectionViewVerticalLayout.alloc.init;
        layout.canDrag = NO;
        layout.header_suspension = NO;
        layout.delegate = self;
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor kl_colorWithHexNumber:0xF9F9F9];
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
