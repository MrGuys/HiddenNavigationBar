//
//  ThirdViewController.m
//  HiddenNavigationBar
//
//  Created by xiaolang on 2017/9/18.
//  Copyright © 2017年 zx. All rights reserved.
//

#import "ThirdViewController.h"
#import "FourViewController.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"button" forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}


- (void)click{
    FourViewController *fourVC = [FourViewController new];
    [self.navigationController pushViewController:fourVC animated:YES];
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
