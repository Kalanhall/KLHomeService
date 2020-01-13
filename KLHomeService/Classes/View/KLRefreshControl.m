//
//  KLRefreshControl.m
//  KLHomeService
//
//  Created by Logic on 2020/1/13.
//

#import "KLRefreshControl.h"

#define k_FMRefresh_Height 60   //控件的高度
#define k_FMRefresh_Width [UIScreen mainScreen].bounds.size.width //控件的宽度
typedef NS_ENUM(NSInteger, FMRefreshState) {
    FMRefreshStateNormal = 0,     /** 普通状态 */
    FMRefreshStatePulling,        /** 释放刷新状态 */
    FMRefreshStateRefreshing,     /** 正在刷新 */
};

@interface KLRefreshControl ()

@property (nonatomic, strong) UIView  *backgroundView;
@property (assign, nonatomic) id refreshTarget;
@property (nonatomic, assign) SEL refreshAction;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) FMRefreshState currentStatus;
@property (nonatomic, strong) UIScrollView *superScrollView;
@property (nonatomic, assign) CGFloat originY;

@end

@implementation KLRefreshControl

- (instancetype)initWithTargrt:(id)target refreshAction:(SEL)refreshAction
{
    self = [super initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, k_FMRefresh_Height)];
    if (self) {
        self.refreshTarget = target;
        self.refreshAction = refreshAction;
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        
        self.label = UILabel.alloc.init;
        self.label.textColor = UIColor.whiteColor;
        self.label.font = [UIFont systemFontOfSize:11];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.text = NSLocalizedString(FM_Refresh_normal_title, nil);
        [self.backgroundView addSubview:self.label];
        self.label.frame = CGRectMake(0, self.frame.size.height - 20, UIScreen.mainScreen.bounds.size.width, 20);
    }
    return self;
}

- (void)dealloc
{
    [self.superScrollView removeObserver:self forKeyPath:@"contentOffset"];
}


#pragma mark - KVO
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        self.superScrollView = (UIScrollView *)self.superview;
        self.originY = -self.superScrollView.contentInset.top;
        [self.superScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    // 移除系统菊花
    [self.subviews.firstObject removeFromSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
     if (self.superScrollView.isDragging && !self.isRefreshing) {
         CGFloat offsetY =  -self.superScrollView.contentInset.top - k_FMRefresh_Height;
        if (self.currentStatus == FMRefreshStatePulling && self.superScrollView.contentOffset.y > offsetY) {
            self.currentStatus = FMRefreshStateNormal;
            self.label.text = FM_Refresh_normal_title;
        } else if (self.currentStatus == FMRefreshStateNormal && self.superScrollView.contentOffset.y < offsetY) {
            self.currentStatus = FMRefreshStatePulling;
            self.label.text = FM_Refresh_pulling_title;
        }
    } else if(!self.superScrollView.isDragging) {
        if (self.currentStatus == FMRefreshStatePulling) {
            self.currentStatus = FMRefreshStateRefreshing;
            self.label.text = FM_Refresh_Refreshing_title;
            [self beginRefreshing];
            [self doRefreshAction];
            [self.superScrollView setContentOffset:(CGPoint){0, self.originY - 40} animated:YES];
        }
    }
    
    CGFloat pullDistance = -self.frame.origin.y;
    self.backgroundView.frame = CGRectMake(0, 0, k_FMRefresh_Width, pullDistance);
    self.label.frame = CGRectMake(0, -self.frame.size.height * 1.1/3.0 + pullDistance, self.label.frame.size.width, self.label.frame.size.height);
}

#pragma mark - action

- (void)doRefreshAction
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (self.refreshTarget && [self.refreshTarget respondsToSelector:self.refreshAction])
        [self.refreshTarget performSelector:self.refreshAction];
#pragma clang diagnostic pop
    
}

- (void)beginRefreshing
{
    [super beginRefreshing];
}

- (void)endRefreshing
{
    self.currentStatus = FMRefreshStateNormal;
    self.label.text = FM_Refresh_Refreshing_title;
    [super endRefreshing];
    [self.superScrollView setContentOffset:CGPointMake(0, self.originY) animated:YES];
}

@end
