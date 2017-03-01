//
//  LGScrollView.h
//  顶部滚动菜单
//
//  Created by admin on 16/6/12.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGScrollView : UIView

/**
 *  初始化，titleArray：标题字符串；viewControllers：包含控制器名称字符串的数组；VC：当前控制器
 *
 *  @param titleArray      标题
 *  @param titleWidth      标题宽度
 *  @param viewControllers 控制器名称
 *  @param VC              当前控制器
 */
- (void)setWithTitleArray:(NSArray *)titleArray TitleWidth:(CGFloat)titleWidth ViewControllers:(NSArray *)viewControllers ViewController:(UIViewController *)VC;

@end
