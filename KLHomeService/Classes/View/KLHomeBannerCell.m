//
//  KLHomeBannerCell.m
//  KLHomeService
//
//  Created by Kalan on 2020/1/11.
//

#import "KLHomeBannerCell.h"
@import Masonry;
@import KLCategory;
@import SDWebImageWebPCoder;

@interface KLHomeBannerCell ()

@property (strong, nonatomic) KLCarouselViewLayout *layout;

@end

@implementation KLHomeBannerCell

+ (void)load
{
    [SDImageCodersManager.sharedManager addCoder:SDImageWebPCoder.sharedCoder];
    [SDWebImageDownloader.sharedDownloader setValue:@"image/webp,image/*,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        KLCarouselViewLayout *layout = KLCarouselViewLayout.alloc.init;
        layout.itemSpacing = 10;
        layout.itemHorizontalCenter = YES;
        layout.itemVerticalCenter = YES;
        layout.layoutType = KLCarouselTransformLayoutTypeNormal;
        self.carousel = [KLCarousel carouselWithFrame:CGRectZero layout:layout cell:nil];
        self.carousel.control.pageIndicatorSpaing = 4;
        self.carousel.control.pageIndicatorSize = CGSizeMake(7, 2.5);
        self.carousel.control.currentPageIndicatorSize = CGSizeMake(10, 2.5);
        self.carousel.control.pageIndicatorTintColor = [UIColor.whiteColor colorWithAlphaComponent:0.3];
        self.carousel.control.currentPageIndicatorTintColor = UIColor.whiteColor;
        [self.contentView addSubview:self.carousel];
        [self.carousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        self.layout = layout;
        
        self.carousel.cellForItemAtIndex = ^(KLCarouselCell * _Nonnull cell, NSArray * _Nonnull images, NSInteger index) {
            cell.imageView.backgroundColor = KLColor(0xF6F6F6);
            cell.imageView.layer.cornerRadius = 5;
            cell.imageView.layer.masksToBounds = YES;
            cell.layer.shadowColor = UIColor.blackColor.CGColor;
            cell.layer.shadowOffset = CGSizeMake(0, 0);
            cell.layer.shadowOpacity = 0.2;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:images[index]]];
        };
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.carousel.frame = self.frame;
    self.layout.itemSize = CGSizeMake(self.frame.size.width - 20, self.frame.size.height);
    self.carousel.control.frame = CGRectMake(0, CGRectGetHeight(self.frame) - KLAuto(15), CGRectGetWidth(self.frame), KLAuto(10));
}

@end
