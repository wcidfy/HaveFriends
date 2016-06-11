//
//  RegisterView.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "RegisterView.h"
@interface RegisterView()
{
    UIView *_blackView;
    UILabel *_titleLable;
}
@end
@implementation RegisterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _blackView=[[UIView alloc]init];
        _blackView.backgroundColor=[UIColor grayColor];
        [self addSubview:_blackView];
        
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_blackView addSubview:_cancelButton];
        
        _titleLable=[[UILabel alloc]init];
        _titleLable.textAlignment=NSTextAlignmentCenter;
        _titleLable.text=@"注册";
        [_blackView addSubview:_titleLable];
        
        _registerName=[[UITextField alloc]init];
        _registerName.placeholder=@"请输入用户名";
        _registerName.textAlignment=NSTextAlignmentCenter;
        _registerName.layer.borderWidth=1;
        _registerName.layer.borderColor=[UIColor grayColor].CGColor;
        [self addSubview:_registerName];
        
        _registerPwd=[[UITextField alloc]init];
        _registerPwd.placeholder=@"请输入 密码";
        _registerPwd.textAlignment=NSTextAlignmentCenter;
        _registerPwd.layer.borderWidth=1;
        _registerPwd.layer.borderColor=[UIColor grayColor].CGColor;
        [self addSubview:_registerPwd];
        
        _registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerButton.backgroundColor=[UIColor greenColor];
        [self addSubview:_registerButton];
        
    }

    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _blackView.frame=CGRectMake(0, 20, XXWIDTH, 44);
    _cancelButton.frame=CGRectMake(0, 0, 60, 44);
    _titleLable.centerX=_blackView.centerX;
    _titleLable.size=CGSizeMake(60, 44);
    
    _registerName.frame=CGRectMake(20, _blackView.y+44+44, XXWIDTH-40, 40);
    _registerPwd.frame=CGRectMake(20, _registerName.y+40+10, XXWIDTH-40, 40);
    _registerButton.frame=CGRectMake(20, _registerPwd.y+40+20, XXWIDTH-40, 40);
    

}
@end
