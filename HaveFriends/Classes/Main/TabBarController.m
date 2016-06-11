//
//  TabBarController.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "HomeController.h"
#import "DiscoverController.h"
#import "AddressBookController.h"
#import "MeController.h"
@interface TabBarController ()

@end

@implementation TabBarController
+(void)initialize
{

    
    UITabBarItem *barItem=[UITabBarItem appearance];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addControllers];
}
#pragma mark 添加控制器
-(void)addControllers
{
    HomeController *home=[[HomeController alloc]init];
    [self addController:home image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"主页"];
    AddressBookController *addressBook=[[AddressBookController alloc]init];
    [self addController:addressBook image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"通讯录"];
    DiscoverController *discover=[[DiscoverController alloc]init];
    [self addController:discover image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"发现"];
    MeController *me=[[MeController alloc]init];
    [self addController:me image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我"];

}
#pragma mark 控制器 tabbaritem设置
-(void)addController:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    vc.title=title;
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NavigationController *nav=[[NavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];

}
@end
