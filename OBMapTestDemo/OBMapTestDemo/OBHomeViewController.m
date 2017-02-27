//
//  OBHomeViewController.m
//  OBMapTestDemo
//
//  Created by obally on 17/2/27.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBHomeViewController.h"

@interface OBHomeViewController ()

@end

@implementation OBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
