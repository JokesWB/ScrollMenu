//
//  ViewController.m
//  顶部滚动菜单
//
//  Created by admin on 16/6/12.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "ViewController.h"
#import "LGScrollView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    OneViewController *oneVC = [[OneViewController alloc] init];
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    ThreeViewController *threeVC = [[ThreeViewController alloc] init];
    
    LGScrollView *view = [[LGScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setWithTitleArray:@[@"标题1", @"标题2", @"标题3"]
        TitleWidth:0 ViewControllers:@[oneVC, twoVC, threeVC] ViewController:self];
    
    [self.view addSubview:view];
}



@end
