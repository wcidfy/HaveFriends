//
//  LoginController.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import "AppDelegate.h"
#import "TabBarController.h"
#import "RegisterController.h"
#import "AccountTool.h"
@interface LoginController ()
@property(nonatomic,strong)LoginView *loginView;
@end

@implementation LoginController
-(void)loadView
{
    _loginView=[[LoginView alloc]init];
    self.view=_loginView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buttonClicks];
}
#pragma mark loginview中button点击方法
-(void)buttonClicks
{
        [_loginView.loginCancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.loginNoCancel addTarget:self action:@selector(noCancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.loginNewUser addTarget:self action:@selector(newUserClick) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark 登录点击
-(void)cancelClick
{
    if ([_loginView.loginName.text isEqualToString:@""]||[_loginView.loginPwd.text isEqualToString:@""])
    {

//        [MBProgressHUD showError:@"QQ号或密码为空！"];
        [ABCommonTools showInstrutions:@"QQ号或密码为空！"];
        return;
    }
    [MBProgressHUD showMessage:@"登录中。。。。"];
//    把用户名密码保存到沙盒
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    [ud setObject:_loginView.loginName.text forKey:@"name"];
//    [ud setObject:_loginView.loginPwd.text forKey:@"pwd"];
//    [ud synchronize];
    [AccountTool shareAccount].loginUser=_loginView.loginName.text;
    [AccountTool shareAccount].loginPwd=_loginView.loginPwd.text;
    __weak typeof(self) weakSelf=self;
    [XMPPTool sharedXMPPTool].registerOperation=NO;
    [[XMPPTool sharedXMPPTool] xmppLogin:^(XMPPResultType resulType) {

            [weakSelf handXMPPResultType:resulType];
    }];

}


-(void)handXMPPResultType:(XMPPResultType)resultType
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if (resultType==XMPPResultTypeLoginSucess) {
            TabBarController *tabBar=[[TabBarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=tabBar;
            [AccountTool shareAccount].login=YES;
            [[AccountTool shareAccount]saveAccount];
        }else
        {
            
            [MBProgressHUD showError:@"用户名或密码错误"];
           
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"name"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"pwd"];

        }
       
    });
   

}

#pragma mark 无法登录电价
-(void)noCancelClick
{

}
#pragma mark 新用户点击
-(void)newUserClick
{

    RegisterController *registerController=[[RegisterController alloc]init];
    [self presentViewController:registerController animated:NO completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_loginView.loginName resignFirstResponder];
    [_loginView.loginPwd resignFirstResponder];

}

@end
