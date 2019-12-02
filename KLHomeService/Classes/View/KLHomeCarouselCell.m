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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        KLCarouselViewLayout *layout = KLCarouselViewLayout.alloc.init;
        layout.itemSpacing = 10;
        layout.itemHorizontalCenter = YES;
        layout.itemVerticalCenter = YES;
        layout.layoutType = KLCarouselTransformLayoutTypeCoverflow;
        self.layout = layout;
        
        self.carousel = [KLCarousel carouselWithFrame:CGRectZero layout:self.layout cell:nil];
        self.carousel.control.currentPageIndicatorTintColor = UIColor.blackColor;
        self.carousel.control.pageIndicatorSize = CGSizeMake(10, 5);
        self.carousel.control.currentPageIndicatorSize = CGSizeMake(10, 5);
        self.carousel.control.pageIndicatorSpaing = 5;
        [self.contentView addSubview:self.carousel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 控件以frame布局，需要重置控件内部控件尺寸
    self.carousel.frame = self.frame;
    self.layout.itemSize = CGSizeMake(self.frame.size.width * 0.8, self.frame.size.height * 0.8);
    self.carousel.control.frame = CGRectMake(0, self.frame.size.height * 0.9, CGRectGetWidth(self.frame), self.frame.size.height * 0.1);
}

@end
