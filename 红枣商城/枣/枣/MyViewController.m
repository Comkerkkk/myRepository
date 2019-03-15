//
//  MyViewController.m
//  枣
//
//  Created by Comker on 2019/1/15.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "MyViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "FindViewController.h"
#import "CartviewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化视图
    HomeViewController*homeVC=[[HomeViewController alloc]init];
    MineViewController*mineVC=[[MineViewController alloc]init];
    FindViewController*findVC=[[FindViewController alloc]init];
    CartViewController*cartVC=[[CartViewController alloc]init];
    
    //添加导航控制器
    UINavigationController*homeNav=[[UINavigationController alloc]initWithRootViewController:homeVC];
    UINavigationController*mineNav=[[UINavigationController alloc]initWithRootViewController:mineVC];
    UINavigationController*findNav=[[UINavigationController alloc]initWithRootViewController:findVC];
    UINavigationController*cartNav=[[UINavigationController alloc]initWithRootViewController:cartVC];
    
    //设置控制器文字
    homeNav.title=@"首页";
    mineNav.title=@"我的";
    findNav.title=@"发现";
    cartNav.title=@"购物车";
    
    //设置控制器图片
    homeNav.tabBarItem.image=[[UIImage imageNamed:@"tab_btn_home_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.selectedImage=[[UIImage imageNamed:@"tab_btn_home_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    mineNav.tabBarItem.image=[[UIImage imageNamed:@"tab_btn_me_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage=[[UIImage imageNamed:@"tab_btn_me_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    findNav.tabBarItem.image=[[UIImage imageNamed:@"tab_btn_found_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    findNav.tabBarItem.selectedImage=[[UIImage imageNamed:@"tab_btn_found_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    cartNav.tabBarItem.image=[[UIImage imageNamed:@"tab_btn_shopping_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cartNav.tabBarItem.selectedImage=[[UIImage imageNamed:@"tab_btn_shopping_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //文字选中后的颜色
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:178.0/255.0 green:6.0/255.0 blue:16.0/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    //创建一个数组包含四个导航控制器
    NSArray*vcArray=[NSArray arrayWithObjects:homeNav,cartNav,findNav, mineNav, nil];
    
    //将数组传给UITabBarController
    self.viewControllers=vcArray;
    
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
