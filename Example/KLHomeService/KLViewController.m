//
//  KLViewController.m
//  KLHomeService
//
//  Created by Kalanhall@163.com on 11/29/2019.
//  Copyright (c) 2019 Kalanhall@163.com. All rights reserved.
//

#import "KLViewController.h"
@import KLHomeServiceInterface;
@import KLNavigationController;

@interface KLViewController ()

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITabBarController *tab = UITabBarController.alloc.init;
    UIViewController *vc = [KLServer.sharedServer fetchHomeController:nil];
    KLNavigationController *nav = [KLNavigationController.alloc initWithRootViewController:vc];
    nav.tabBarItem = [UITabBarItem.alloc initWithTabBarSystemItem:UITabBarSystemItemHistory tag:0];
    tab.viewControllers = @[nav];
    
    [self addChildViewController:tab];
    [self.view addSubview:tab.view];
}

@end
