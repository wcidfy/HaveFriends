//
//  ChatView.m
//  HaveFriends
//
//  Created by lxx on 16/6/13.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "ChatView.h"

@interface ChatView()
{
    UIView *_blackView;
    
}
@end
@implementation ChatView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _blackView=[[UIView alloc]init];
        _blackView.backgroundColor=[UIColor grayColor];
        [self addSubview:_blackView];
        
        _titleLable=[[UILabel alloc]init];
        _titleLable.text=@"聊天界面";
        _titleLable.textColor=[UIColor blackColor];
        _titleLable.font=[UIFont systemFontOfSize:18];
        _titleLable.textAlignment=NSTextAlignmentCenter;
        [_blackView addSubview:_titleLable];
        
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"GoBack" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_blackView addSubview:_cancelButton];
        
        _enterButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_enterButton setTitle:@"" forState:UIControlStateNormal];
        [_enterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_blackView addSubview:_enterButton];
        
        _tableView=[[BKTableView alloc]init];
        [self addSubview:_tableView];
        
        _inputView=[[UIView alloc]init];
        _inputView.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:_inputView];
        _inputTextView=[[UITextView alloc]init];
        _inputTextView.backgroundColor=[UIColor whiteColor];
        _inputTextView.layer.borderWidth=1;
        _inputTextView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _inputTextView.layer.masksToBounds=YES;
        _inputTextView.returnKeyType = UIReturnKeyDefault;
        _inputTextView.layer.cornerRadius=10;
        [_inputView addSubview:_inputTextView];
        
        _sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_inputView addSubview:_sendButton];
        
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
    _tableView.frame=CGRectMake(0, 64, XXWIDTH, XXHEIGHT-64-49);
    _inputView.frame=CGRectMake(0, XXHEIGHT-49, XXWIDTH, 49);
    _inputTextView.frame=CGRectMake(10, 5, XXWIDTH-10-50-10, 40);
    
    _sendButton.frame=CGRectMake(XXWIDTH-50, 5, 40, 40);
}


@end
