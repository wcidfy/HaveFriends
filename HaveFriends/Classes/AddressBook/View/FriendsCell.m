//
//  FriendsCell.m
//  HaveFriends
//
//  Created by lxx on 16/6/15.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImage=[[UIImageView alloc]init];
        _headImage.layer.masksToBounds=YES;
        _headImage.layer.cornerRadius=25;
        [self.contentView addSubview:_headImage];
        _nameLable=[[UILabel alloc]init];
        _nameLable.textColor=[UIColor redColor];
        _nameLable.font=[UIFont systemFontOfSize:14];
        _nameLable.numberOfLines=0;
        [self.contentView addSubview:_nameLable];
        
        _stateLable=[[UILabel alloc]init];
        _stateLable.textColor=[UIColor redColor];
        _stateLable.font=[UIFont systemFontOfSize:14];
        _stateLable.numberOfLines=0;
        [self.contentView addSubview:_stateLable];
        
        _unreadMessage=[UIButton buttonWithType:UIButtonTypeCustom];
        _unreadMessage.layer.masksToBounds=YES;
        _unreadMessage.layer.borderWidth=1;
        _unreadMessage.layer.borderColor=[UIColor redColor].CGColor;
        _unreadMessage.backgroundColor=[UIColor redColor];
        _unreadMessage.layer.cornerRadius=10;
        [self.contentView addSubview:_unreadMessage];
        
        
    }
    
    return self;
}
-(void)setImage:(UIImage *)imageStr nameStr:(NSString *)nameStr stateStr:(NSString *)stateStr buttonStr:(NSNumber *)buttonStr
{
      _headImage.frame=CGRectMake(10, 5, 50, 50);
    _headImage.image=imageStr;
    
    _nameLable.frame=CGRectMake(10+50+10, 10, 200, 15);
    _nameLable.text=nameStr;
    
    _stateLable.frame=CGRectMake(10+50+10, 35, 200, 15);
    _stateLable.text=stateStr;
    
    if ([buttonStr intValue]>0) {
        _unreadMessage.frame=CGRectMake(XXWIDTH-30, 20, 20, 20);
        [_unreadMessage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_unreadMessage setTitle:[NSString stringWithFormat:@"%@",buttonStr] forState:UIControlStateNormal];
    }else
        _unreadMessage.hidden=YES;
   
}

@end
