//
//  KLCarouselSubCell.m
//  KLHomeService
//
//  Created by Logic on 2019/12/3.
//

#import "KLCarouselSubCell.h"

@implementation KLCarouselSubCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

@end
