//
//  BaseNavigationViewController.m
//  HiddenNavigationBar
//
//  Created by xiaolang on 2017/9/18.
//  Copyright © 2017年 zx. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "SecondViewController.h"
#import "BaseTabBarViewController.h"
@interface BaseNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"tableView willShow viewcontrollers %lu", [self viewControllers].count);
    
    
    BOOL hiddenAnimate = NO;
    NSInteger count = ((BaseTabBarViewController *)viewController.tabBarController).delayIndex;
    NSLog(@"tableView willShow delayIndex %ld",(long)count);
    if (count == 2) {
        hiddenAnimate = YES;
    }
    BOOL isShowHomePage = [viewController isKindOfClass:[SecondViewController class]];
    
    [self setNavigationBarHidden:isShowHomePage animated:hiddenAnimate];
    
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController.tabBarController.selectedIndex == 2 && [self.viewControllers count] > 1) {
        ((BaseTabBarViewController *)viewController.tabBarController).delayIndex = viewController.tabBarController.selectedIndex;

    }
    NSLog(@"tableView didShow viewcontrollers %lu", [self viewControllers].count);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
