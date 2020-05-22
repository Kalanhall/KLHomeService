//
//  KLHomeController.m
//  KLHomeService
//
//  Created by Logic on 2019/11/29.
//

#import "KLHomeController.h"
@import Masonry;
@import KLCategory;
@import KLNavigationController;

@interface KLHomeController ()

@end

@implementation KLHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor kl_colorWithHexNumber:0xF9F9F9];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    KLHomeController *vc = KLHomeController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
