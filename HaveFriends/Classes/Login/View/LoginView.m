//
//  LoginView.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "LoginView.h"
@interface LoginView()
{
    UIView *lineView;
}
@end
@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor lightGrayColor];
        _headImage=[[UIImageView alloc]init];
        _headImage.layer.masksToBounds=YES;
        _headImage.layer.cornerRadius=40;
        _headImage.backgroundColor=[UIColor redColor];
        [self addSubview:_headImage];
        
        UIView *nameLeftView=[[UIView alloc]init];
        nameLeftView.frame=CGRectMake(0, 0, 10, 40);
       
        _loginName=[[UITextField alloc]init];
        _loginName.leftView=nameLeftView;
        _loginName.backgroundColor=[UIColor whiteColor];
        _loginName.leftViewMode=UITextFieldViewModeAlways;
        
       
        _loginName.placeholder=@"QQ号／手机号／邮箱";
        _loginName.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_loginName];
        
        lineView=[[UIView alloc]init];
        lineView.backgroundColor=[UIColor grayColor];
        [self addSubview:lineView];
        
        UIView *pwdLeftView=[[UIView alloc]init];
        pwdLeftView.frame=CGRectMake(0, 0, 10, 40);
        _loginPwd=[[UITextField alloc]init];
        _loginPwd.backgroundColor=[UIColor whiteColor];
        _loginPwd.leftView=pwdLeftView;
        _loginPwd.leftViewMode=UITextFieldViewModeAlways;

        _loginPwd.placeholder=@"密码";
        _loginPwd.secureTextEntry=YES;
        [self addSubview:_loginPwd];
        
        _loginCancel=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginCancel setTitle:@"登录" forState:UIControlStateNormal];
        _loginCancel.backgroundColor=[UIColor blueColor];
        _loginCancel.layer.masksToBounds=YES;
        _loginCancel.layer.cornerRadius=10;
        [self addSubview:_loginCancel];
        
        _loginNoCancel=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginNoCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_loginNoCancel setTitle:@"无法登录？" forState:UIControlStateNormal];
        [self addSubview:_loginNoCancel];
        
        _loginNewUser=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginNewUser setTitle:@"新用户" forState:UIControlStateNormal];
        [_loginNewUser setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:_loginNewUser];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _headImage.centerX=self.centerX;
    _headImage.size=CGSizeMake(80, 80);
    _headImage.y=XXWIDTH*0.2;
    _loginName.frame=CGRectMake(0, _headImage.y+90, XXWIDTH, 40);
    lineView.frame=CGRectMake(0, _loginName.y+40, XXWIDTH, 1);
    _loginPwd.frame=CGRectMake(0, _loginName.y+41, XXWIDTH, 40);
    
    _loginCancel.frame=CGRectMake(10, _loginPwd.y+50, XXWIDTH-20, 40);

    _loginNoCancel.frame=CGRectMake(10, XXHEIGHT-50, 100, 40);
    _loginNewUser.frame=CGRectMake(XXWIDTH-100, XXHEIGHT-50, 100, 40);
}
@end
