//
//  RegisterController.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterView.h"
#import "LoginController.h"
#import "AccountTool.h"
@interface RegisterController ()
@property(nonatomic,strong)RegisterView *registerView;


@end

@implementation RegisterController
-(void)loadView
{
    [super loadView];
    _registerView=[[RegisterView alloc]init];
    self.view=_registerView;

}
#pragma mark view z中按钮点击方法
-(void)buttonClick
{
    [_registerView.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
     [_registerView.registerButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buttonClick];
}
#pragma mark 点击取消按钮
-(void)cancelClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 点击注册按钮

-(void)registerClick
{
    //注册
//     1 。发送注册Jid 给服务器 建立长连接
//     2. 连接成功 发送注册密码
    if ([_registerView.registerName.text isEqualToString:@""]||[_registerView.registerPwd.text isEqualToString:@""]) {
        [ABCommonTools showInstrutions:@"QQ号或密码为空！"];
        return;
    }
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    [ud setObject:_registerView.registerName.text forKey:@"registerName"];
//    [ud setObject:_registerView.registerPwd.text forKey:@"registerPwd"];
//    [ud synchronize];
    [AccountTool shareAccount].registerUser=_registerView.registerName.text;
    [AccountTool shareAccount].registerPwd=_registerView.registerPwd.text;
    [MBProgressHUD showMessage:@"正在注册。。。。"];
    [XMPPTool sharedXMPPTool].registerOperation=YES;
    __weak typeof(self)weakSelf=self;
    [[XMPPTool sharedXMPPTool]xmppRegister:^(XMPPResultType resultType) {

        
        [weakSelf handXMPPResultType:resultType];
    }];
}
-(void)handXMPPResultType:(XMPPResultType)resultType
{
    //在主线程工作
    dispatch_async(dispatch_get_main_queue(), ^{
        
       
        [MBProgressHUD hideHUD];
        // 2.提示注册成功
        if (resultType == XMPPResultTypeRegisterSucess) {
            LoginController *login=[[LoginController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=login;
            [MBProgressHUD showSuccess:@"恭喜注册成功，请登录..."];
        }else{
            [MBProgressHUD showError:@"用户名重复"];
        }
        
        
    });
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_registerView.registerName resignFirstResponder];
    [_registerView.registerPwd resignFirstResponder];

}
@end
