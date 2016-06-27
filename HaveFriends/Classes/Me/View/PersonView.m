//
//  PersonView.m
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "PersonView.h"
@interface PersonView()
{
    UIView *_blackView;
    
}
@end
@implementation PersonView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        _blackView=[[UIView alloc]init];
        _blackView.backgroundColor=[UIColor grayColor];
        [self addSubview:_blackView];
        
        _titleLable=[[UILabel alloc]init];
        _titleLable.text=@"我";
        _titleLable.textColor=[UIColor blackColor];
        _titleLable.font=[UIFont systemFontOfSize:18];
        _titleLable.textAlignment=NSTextAlignmentCenter;
        [_blackView addSubview:_titleLable];
        
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_blackView addSubview:_cancelButton];
        
        _tableView=[[BKTableView alloc]init];
        [self addSubview:_tableView];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _blackView.frame=CGRectMake(0, 20, XXWIDTH, 44);
    _titleLable.centerx=_blackView.centerx;
    _titleLable.size=CGSizeMake(60, 44);
    _cancelButton.frame=CGRectMake(0, 0, 60, 44);
    _tableView.frame=CGRectMake(0, 64+20, XXWIDTH, XXHEIGHT-64-20);


}
@end
