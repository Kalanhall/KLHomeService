//
//  KLHomeImageTitleCell.m
//  KLHomeService
//
//  Created by Logic on 2019/11/29.
//

#import "KLHomeImageTitleCell.h"
@import Masonry;
@import KLCategory;

@implementation KLHomeImageTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor = [UIColor kl_colorWithHexNumber:0xF9F9F9].CGColor;
        
        self.imageView = UIImageView.alloc.init;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(4/3.0);
        }];

        self.textLabel = UILabel.alloc.init;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textColor = UIColor.blackColor;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
    }
    return self;
}

@end
