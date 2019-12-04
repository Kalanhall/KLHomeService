//
//  KLDynamicNavigationBar.h
//  KLHomeService
//
//  Created by Logic on 2019/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLDynamicNavigationBar : UIView

@property (strong, nonatomic, readonly) UIScrollView *scrollView;   // 被监听的滚动视图
@property (strong, nonatomic) UIImageView *backgroundView;          // 导航栏背景图
@property (strong, nonatomic) UIImageView *botView;                 // 导航栏背景图底部占位图，图片与backgroundView一致，层级位于scrollView的superView上
@property (strong, nonatomic) UIImageView *topView;                 // 导航栏背景图底部活动预告图，层级位于scrollView的superView上
@property (strong, nonatomic, readonly) UITextField *searchBar;
@property (copy  , nonatomic) NSString *searchBarPlaceholder;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) NSArray <UIView *> *leftViews;
@property (strong, nonatomic) NSArray <UIView *> *rightViews;

@property (strong, nonatomic) void (^searchBarDidBeginEditing)(void);

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// 构造方法
/// @Param frame bar尺寸
/// @Param scrollView 需要监听位移的滚动视图
///
/// @Return KLDynamicNavigationBar 实例
///
- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView;

/// 监听滚动视图移动，改变内部视图显示
///
/// scrollViewDidScroll 代理中调用
///
/// @Param space bar预留给右视图的位置
/// @Param height 刷新控件高度
///
- (void)dynamicWithRightSpace:(CGFloat)space refreshHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
