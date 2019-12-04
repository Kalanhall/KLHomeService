//
//  KLHomeWebController.m
//  KLHomeService
//
//  Created by Logic on 2019/12/4.
//

#import "KLHomeWebController.h"

@interface KLHomeWebController ()

@end

@implementation KLHomeWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"活动页";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
