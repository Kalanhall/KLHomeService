//
//  KLHomeMenuCell.m
//  KLHomeService
//
//  Created by Kalan on 2020/1/11.
//

#import "KLHomeMenuCell.h"
@import Masonry;
@import KLCategory;

@implementation KLHomeMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundImageView = UIImageView.alloc.init;
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.backgroundImageView];
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
            make.height.mas_equalTo(KLAuto(144));
        }];
    }
    return self;
}

@end
