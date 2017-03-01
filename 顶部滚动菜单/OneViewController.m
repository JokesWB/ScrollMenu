//
//  OneViewController.m
//  顶部滚动菜单
//
//  Created by admin on 16/6/12.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"
#import "MyViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    NSLog(@"我是第一页");
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"hahaha" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonAction
{
    MyViewController *VC = [[MyViewController alloc] init];
    VC.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController pushViewController:VC animated:YES];
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
