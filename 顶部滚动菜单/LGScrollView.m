//
//  LGScrollView.m
//  顶部滚动菜单
//
//  Created by admin on 16/6/12.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kTitleScrollViewH 40  //标题视图宽度
#define kTitleBtnW 80      //按钮宽度
#define kTitleBtnH 35      //按钮高度
#define kLineW 30           //下划线宽度
#define kLineH 2           //下划线高度
#define kBtnCount 4        //按钮个数分界线
#define kTag 100000

#import "LGScrollView.h"


@interface LGScrollView ()<UIScrollViewDelegate>
{
    CGFloat _btnW;   //按钮宽度
    BOOL _canScroll;
}

@property (nonatomic , strong) NSArray *titleArray;   //标题
@property (nonatomic , strong) NSArray *viewControllers;  //控制器名称
@property (nonatomic , strong) UIScrollView *titleScrollView;  //标题滚动视图
@property (nonatomic , strong) UIScrollView *contentScrollView; //内容滚动视图
@property (nonatomic , strong) NSMutableArray *isFinishedArray;
@property (nonatomic , strong) UIView *lineView;  //下划线
@property (nonatomic , strong) UIButton *selectedBtn;
@property (nonatomic , strong) UIViewController *VC;

@end

@implementation LGScrollView

- (void)setWithTitleArray:(NSArray *)titleArray TitleWidth:(CGFloat)titleWidth ViewControllers:(NSArray *)viewControllers ViewController:(UIViewController *)VC
{
    self.titleArray = titleArray;
    self.viewControllers = viewControllers;
    self.VC = VC;
    //设置内容视图的contentSize
    CGSize size = titleArray.count > kBtnCount ? CGSizeMake(kTitleBtnW * titleArray.count, 0) : CGSizeMake(kScreenW / titleArray.count, 0);
    self.titleScrollView.contentSize = size;
    
    if (titleWidth != 0) {
        self.titleScrollView.frame = CGRectMake(0, 0, titleWidth, kTitleScrollViewH);
    }
//    按钮宽度
    _btnW = titleArray.count > kBtnCount ? kTitleBtnW : self.titleScrollView.frame.size.width / titleArray.count;
    //如果标题小于 kBtnCount ，就不用设置标题偏移
    _canScroll = titleArray.count > kBtnCount ? YES : NO;
    
    //创建btn
    [self createButtonWithTitleArray:titleArray];
    
    for (int i = 0; i < titleArray.count; i++) {
        [self.isFinishedArray addObject:@0];
    }
    //添加子控制器
    [self addChildViewControllersWithIndex:0];
    
}

//创建button
- (void)createButtonWithTitleArray:(NSArray *)titleArray
{
    CGFloat btnH = kTitleBtnH;
    CGFloat btnY = 0;
    for (int i = 0; i < titleArray.count; i++) {
        CGFloat btnX = i * _btnW;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, _btnW, btnH);
        btn.tag = kTag + i;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
        //默认选中第一个
        if (i == 0) {
            [self clickBtnAction:btn];
        }
    }
}

//点击标题按钮
- (void)clickBtnAction:(UIButton *)sender
{
    //如果前后点击的是同一个按钮
    if (self.selectedBtn == sender) {
        return;
    }
    
    //设置内容视图的偏移
    [self setContentViewOffset:sender];
    
    if (_canScroll) {
        //设置标题的偏移 (（拿scrollView的总宽度 - btn距离中心的的距离） 和 kScreenW 相比较)
        [self setTittleViewOffset:sender];
    }
    
    //下划线的偏移和button的缩放
    [self setLineViewOffset:sender];
    
    //button状态
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

//设置内容视图的偏移
- (void)setContentViewOffset:(UIButton *)sender
{
    [self.contentScrollView setContentOffset:CGPointMake(kScreenW * (sender.tag - kTag), 0) animated:YES];
}

//设置标题的偏移
- (void)setTittleViewOffset:(UIButton *)sender
{
    //（拿scrollView的总宽度 - btn距离中心的的距离） 和 kScreenW 相比较
    CGFloat ddd = self.titleScrollView.contentSize.width - (sender.center.x - self.center.x);
    if (ddd <= kScreenW) {
        //说明最后一个btn已经完全出现了
        [self.titleScrollView setContentOffset:CGPointMake(self.titleScrollView.contentSize.width - kScreenW, 0) animated:YES];
    } else {
        
        if (sender.center.x > self.center.x) {
            [self.titleScrollView setContentOffset:CGPointMake(sender.center.x - self.center.x, 0) animated:YES];
            
        } else {
            [self.titleScrollView setContentOffset:CGPointZero animated:YES];
        }
    }
}

//下划线的偏移和button的缩放
- (void)setLineViewOffset:(UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.lineView.frame;
        rect.origin.x = _btnW * (sender.tag - kTag) + (_btnW - kLineW) * 0.5;
        self.lineView.frame = rect;
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.selectedBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }];
}

//添加子控制器
- (void)addChildViewControllersWithIndex:(NSInteger)index
{
    if ([self.isFinishedArray[index] integerValue] == 0) {
        UIViewController *viewController = self.viewControllers[index];
        viewController.view.frame = CGRectMake(kScreenW * index, 0, kScreenW, self.contentScrollView.frame.size.height);
        [self.contentScrollView addSubview:viewController.view];
        [self.VC addChildViewController:viewController];
        self.isFinishedArray[index] = @1;
    }
}

//用手指滚动scrollView时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.contentScrollView) {
        [self addChildViewControllersWithIndex:scrollView.contentOffset.x / kScreenW];
        UIButton *btn = [self.titleScrollView viewWithTag:kTag + scrollView.contentOffset.x / kScreenW];
        [self clickBtnAction:btn];
    }
}

//点击标题按钮使scrollView滚动时
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == self.contentScrollView) {
        [self addChildViewControllersWithIndex:scrollView.contentOffset.x / kScreenW];
    }
}


//标题滚动视图
- (UIScrollView *)titleScrollView
{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kTitleScrollViewH)];
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.delegate = self;
        self.VC.navigationItem.titleView = _titleScrollView;
    }
    return _titleScrollView;
}

//内容滚动视图
- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
        _contentScrollView.contentSize = CGSizeMake(kScreenW * self.titleArray.count, 0);
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
        [self addSubview:_contentScrollView];
    }
    return _contentScrollView;
}

//下划线
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake((_btnW - kLineW) * 0.5, kTitleBtnH + 2, kLineW, kLineH)];
        _lineView.backgroundColor = [UIColor redColor];
        [self.titleScrollView addSubview:_lineView];
    }
    return _lineView;
}

//用来标记的数组
- (NSMutableArray *)isFinishedArray
{
    if (!_isFinishedArray) {
        _isFinishedArray = [NSMutableArray array];
    }
    return _isFinishedArray;
}

@end
