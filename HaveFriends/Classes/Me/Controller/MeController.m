//
//  MeController.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "MeController.h"
#import "MeView.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "AccountTool.h"
@interface MeController ()
@property(nonatomic,strong)MeView *meView;
@end

@implementation MeController
-(void)loadView
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _meView=[[MeView alloc]init];
    self.view=_meView;
    [_meView.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)cancelClick
{
//    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    [[XMPPTool sharedXMPPTool]  xmppLogout];
    [AccountTool shareAccount].login=NO;
    [[AccountTool shareAccount] saveAccount];

    [self changeToLogin];
}
-(void)changeToLogin
{
    dispatch_async(dispatch_get_main_queue(), ^{
        LoginController *login=[[LoginController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController=login;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loginUser"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loginPwd"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]);
    });
    
}
@end
