//
//  SecondViewController.m
//  HiddenNavigationBar
//
//  Created by xiaolang on 2017/9/18.
//  Copyright © 2017年 zx. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.

    
    
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
- (IBAction)didClickBtn:(UIButton *)sender {
    ThirdViewController *thirdVC = [ThirdViewController new];
    [self.navigationController pushViewController:thirdVC animated:YES];
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
