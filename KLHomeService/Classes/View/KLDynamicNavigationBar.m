//
//  KLDynamicNavigationBar.m
//  KLHomeService
//
//  Created by Logic on 2019/12/3.
//

@import KLCategory;
@import Masonry;

#import "KLDynamicNavigationBar.h"

@interface KLDynamicNavigationBar ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation KLDynamicNavigationBar

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = scrollView;
        NSAssert(scrollView.superview != nil, @"scrollView 必须先添加到self.view上");
        
        self.backgroundView = UIImageView.alloc.init;
        self.backgroundView.contentMode = UIViewContentModeTop;
        self.backgroundView.clipsToBounds = YES;
        [self addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
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
        
        self.botView = UIImageView.alloc.init;
        self.botView.clipsToBounds = YES;
        self.botView.contentMode = UIViewContentModeTop;
        [self.scrollView.superview insertSubview:self.botView belowSubview:self.scrollView];
        [self.botView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(200);
        }];
        
        self.topView = UIImageView.alloc.init;
        self.topView.clipsToBounds = YES;
        self.topView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView.superview insertSubview:self.topView belowSubview:self.scrollView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.botView);
            make.height.mas_equalTo(self.scrollView.superview);
        }];
    }
    return self;
}

- (void)dynamicWithRightSpace:(CGFloat)space {
    CGFloat position = self.scrollView.contentOffset.y;
    
    // 背景图临界值处理
    if (position < -self.scrollView.contentInset.top) {
        // 下拉透明度处理 & 占位图/广告图 位移处理
        CGFloat height = 44.0; // 刷新控件高度
        CGFloat alpha = fabs(position + self.scrollView.contentInset.top) / height;
        self.alpha = 1 - alpha;
        self.backgroundView.alpha = 0;
        self.topView.alpha = alpha;
        if (fabs(position + self.scrollView.contentInset.top) >= height) {
            self.topView.transform = CGAffineTransformMakeTranslation(0, - position - self.scrollView.contentInset.top - height);
        }
        self.botView.alpha = 1 - alpha;
        self.botView.transform = CGAffineTransformIdentity;
    } else {
        // 上拉透明度处理 & 占位图/广告图 位移处理
        self.alpha = 1;
        self.backgroundView.alpha = 1;
        self.topView.alpha = 0;
        self.topView.transform = CGAffineTransformIdentity;
        self.botView.alpha = 1;
        self.botView.transform = CGAffineTransformMakeTranslation(0, - position - self.scrollView.contentInset.top);
    }
    
    // 导航栏临界值处理
    if (position < -self.scrollView.contentInset.top) {
        position = -self.scrollView.contentInset.top;
    } else if (position > -Auto_Top()) {
        position = -Auto_Top();
    }
    self.frame = CGRectMake(self.x, self.y, self.w, fabs(position));
    
    // 导航栏实时移动距离
    CGFloat move = self.scrollView.contentInset.top + position;
    // 搜索栏位移
    CGFloat real = self.scrollView.contentInset.top - Auto_Top();    // 实际经过距离
    CGFloat target = space;                                     // 右侧预留距离
    CGFloat update = move / real * target * 2/*加速到达终点的倍数*/; // 右边间距实时距离
    if (update >= target) {
        update = target;
    }
    [self.searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10 - update);
    }];
    
    // 左视图透明度处理
    CGFloat alpha = 1 - (position + self.scrollView.contentInset.top) / real;
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
        make.width.mas_equalTo(40);
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
                make.width.mas_equalTo(40);
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
                make.width.mas_equalTo(40);
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
