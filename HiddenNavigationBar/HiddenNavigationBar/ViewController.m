//
//  ViewController.m
//  HiddenNavigationBar
//
//  Created by xiaolang on 2017/9/18.
//  Copyright © 2017年 zx. All rights reserved.
//

#import "ViewController.h"
#import "FourViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view, typically from a nib.
    // Do any additional setup after loading the view.
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


@end
