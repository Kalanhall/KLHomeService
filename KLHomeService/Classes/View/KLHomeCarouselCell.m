//
//  KLHomeCarouselCell.m
//  KLHomeService
//
//  Created by Logic on 2019/11/30.
//

#import "KLHomeCarouselCell.h"

@interface KLHomeCarouselCell ()

@property (strong, nonatomic) KLCarouselViewLayout *layout;

@end

@implementation KLHomeCarouselCell

static CGFloat const space = 20;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = UIColor.clearColor;
        
        KLCarouselViewLayout *layout = KLCarouselViewLayout.alloc.init;
        layout.itemSpacing = space * 0.5;
        layout.itemHorizontalCenter = YES;
        layout.itemVerticalCenter = YES;
        layout.layoutType = KLCarouselTransformLayoutTypeNormal;
        self.layout = layout;
        
        self.carousel = [KLCarousel carouselWithFrame:CGRectZero layout:self.layout cell:KLCarouselSubCell.class];
        self.carousel.control.currentPageIndicatorTintColor = UIColor.whiteColor;
        self.carousel.control.pageIndicatorTintColor = [UIColor.whiteColor colorWithAlphaComponent:0.3];
        self.carousel.control.pageIndicatorSize = CGSizeMake(7, 3);
        self.carousel.control.currentPageIndicatorSize = CGSizeMake(10, 3);
        self.carousel.control.pageIndicatorSpaing = 4;
        self.carousel.collectionView.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.carousel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 控件以frame布局，需要重置控件内部控件尺寸
    self.carousel.frame = self.frame;
    self.layout.itemSize = CGSizeMake(self.frame.size.width - space, self.frame.size.height - space);
    self.carousel.control.frame = CGRectMake(0, self.frame.size.height - space * 0.5 - 15, CGRectGetWidth(self.frame), 15);
}

@end
