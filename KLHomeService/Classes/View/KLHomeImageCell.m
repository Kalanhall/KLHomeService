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
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor = [UIColor kl_colorWithHexNumber:0xF9F9F9].CGColor;
    }
    return self;
}

@end
