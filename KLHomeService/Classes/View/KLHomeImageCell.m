//
//  KLHomeImageCell.m
//  KLHomeService
//
//  Created by Logic on 2019/11/29.
//

#import "KLHomeImageCell.h"
@import Masonry;
@import KLCategory;

@implementation KLHomeImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor kl_colorWithHexNumber:0xF9F9F9];
        
        self.imageView = UIImageView.alloc.init;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

@end
