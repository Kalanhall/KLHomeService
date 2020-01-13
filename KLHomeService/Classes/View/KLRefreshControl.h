//
//  KLRefreshControl.h
//  KLHomeService
//
//  Created by Logic on 2020/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *FM_Refresh_normal_title  = @"下拉刷新";
static NSString *FM_Refresh_pulling_title  = @"继续下拉有惊喜";
static NSString *FM_Refresh_Refreshing_title  = @"更新中";

@interface KLRefreshControl : UIRefreshControl

- (instancetype)initWithTargrt:(id)target refreshAction:(SEL)refreshAction;
- (void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
