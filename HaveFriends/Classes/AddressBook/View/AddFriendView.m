//
//  AddFriendView.m
//  HaveFriends
//
//  Created by lxx on 16/6/13.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "AddFriendView.h"

@interface AddFriendView()
{
    UIView *_blackView;
    
}
@end
@implementation AddFriendView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _blackView=[[UIView alloc]init];
        _blackView.backgroundColor=[UIColor grayColor];
        [self addSubview:_blackView];
        
        _titleLable=[[UILabel alloc]init];
        _titleLable.text=@"添加好友";
        _titleLable.textColor=[UIColor blackColor];
        _titleLable.font=[UIFont systemFontOfSize:18];
        _titleLable.textAlignment=NSTextAlignmentCenter;
        [_blackView addSubview:_titleLable];
        
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"GoBack" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_blackView addSubview:_cancelButton];
        
        _enterButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_enterButton setTitle:@"添加" forState:UIControlStateNormal];
        [_enterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_blackView addSubview:_enterButton];
        
        UIView *leftView=[[UIView alloc]init];
        leftView.frame=CGRectMake(0, 0, 20, 40);
        _textFild=[[UITextField alloc]init];
        _textFild.leftView=leftView;
        _textFild.leftViewMode=UITextFieldViewModeAlways;
        _textFild.layer.borderWidth=1;
        _textFild.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [self addSubview:_textFild];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _blackView.frame=CGRectMake(0, 20, XXWIDTH, 44);
    _titleLable.centerx=_blackView.centerx;
    _titleLable.size=CGSizeMake(100, 44);
    _cancelButton.frame=CGRectMake(0, 0, 80, 44);
    
    _enterButton.frame=CGRectMake(XXWIDTH-80, 0, 80, 44);
    _textFild.frame=CGRectMake(0, _blackView.y+44+20, XXWIDTH, 40);
}

@end
