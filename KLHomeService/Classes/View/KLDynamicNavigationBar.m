//
//  KLDynamicNavigationBar.m
//  KLHomeService
//
//  Created by Logic on 2019/12/3.
//

@import KLCategory;
@import Masonry;

#import "KLDynamicNavigationBar.h"

@implementation KLDynamicNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.searchBar = UITextField.alloc.init;
        self.searchBar.backgroundColor = UIColor.whiteColor;
        self.searchBar.layer.cornerRadius = 15;
        self.searchBar.layer.masksToBounds = YES;
        [self addSubview:self.searchBar];
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(-7);
        }];
    }
    return self;
}

- (void)dynamicWithScrollView:(UIScrollView *)scrollView rightSpace:(CGFloat)space {
    CGFloat position = scrollView.contentOffset.y;
    if (position < -scrollView.contentInset.top) {
        position = -scrollView.contentInset.top;
    } else if (position > -Auto_Top()) {
        position = -Auto_Top();
    }
    self.frame = CGRectMake(self.x, self.y, self.w, fabs(position));
    
    CGFloat real = scrollView.contentInset.top - Auto_Top();    // 实际经过距离
    CGFloat target = space;                                     // 右侧预留距离
    CGFloat update = (position + scrollView.contentInset.top) / real * target * 2/*加速到达终点的倍数*/; // 右边间距实时距离
    if (update >= target) {
        update = target;
    }
    [self.searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10 - update);
    }];
    
    CGFloat alpha = 1 - (position + scrollView.contentInset.top) / real;
    self.leftView.alpha = alpha;
    for (UIView *item in self.leftViews) {
        item.alpha = alpha;
    }
}

- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(Auto_Status());
        make.right.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(44.0);
    }];
}

- (void)setRightView:(UIView *)rightView {
    _rightView = rightView;
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(Auto_Status());
        make.width.mas_equalTo(30.0);
        make.height.mas_equalTo(44.0);
    }];
}

- (void)setLeftViews:(NSArray<UIView *> *)leftViews {
    _leftViews = leftViews;
    [leftViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx;
        [self addSubview:obj];
        if (idx == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(-10);
                make.top.mas_equalTo(Auto_Status());
                make.width.mas_equalTo(34.0);
                make.height.mas_equalTo(44.0);
            }];
        } else {
            UIView *view = leftViews[idx - 1];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view.mas_right);
                make.centerY.width.height.mas_equalTo(view);
            }];
        }
    }];
}

- (void)setRightViews:(NSArray<UIView *> *)rightViews {
    _rightViews = rightViews;
    [rightViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx;
        [self addSubview:obj];
        if (idx == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(Auto_Status());
                make.width.mas_equalTo(34.0);
                make.height.mas_equalTo(44.0);
            }];
        } else {
            UIView *view = rightViews[idx - 1];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(view.mas_left);
                make.centerY.width.height.mas_equalTo(view);
            }];
        }
    }];
}

@end
