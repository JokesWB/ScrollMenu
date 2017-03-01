//
//  MyViewController.m
//  顶部滚动菜单
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "MyViewController.h"
#import "LGScrollView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    OneViewController *oneVC = [[OneViewController alloc] init];
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    ThreeViewController *threeVC = [[ThreeViewController alloc] init];
    
    LGScrollView *view = [[LGScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setWithTitleArray:@[@"标题1", @"标题2"]
                 TitleWidth:200 ViewControllers:@[oneVC, twoVC] ViewController:self];

    
    [self.view addSubview:view];
    
    
}
@end
