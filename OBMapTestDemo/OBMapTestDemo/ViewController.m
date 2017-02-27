//
//  ViewController.m
//  OBMapTestDemo
//
//  Created by obally on 17/2/27.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "ViewController.h"
#import "OBHomeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)push
{
    OBHomeViewController *home = [[OBHomeViewController alloc]init];
    [self presentViewController:home animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
