//
//  KLDynamicNavigationBar.h
//  KLHomeService
//
//  Created by Logic on 2019/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLDynamicNavigationBar : UIView

@property (strong, nonatomic) UITextField *searchBar;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) NSArray <UIView *> *leftViews;
@property (strong, nonatomic) UIButton *rightView;
@property (strong, nonatomic) NSArray <UIView *> *rightViews;

- (void)dynamicWithScrollView:(UIScrollView *)scrollView rightSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
