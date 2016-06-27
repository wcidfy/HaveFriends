//
//  ChatCell.m
//  HaveFriends
//
//  Created by lxx on 16/6/14.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImage=[[UIImageView alloc]init];
        _headImage.layer.masksToBounds=YES;
        _headImage.layer.cornerRadius=30;
        [self.contentView addSubview:_headImage];
        _nameLable=[[UILabel alloc]init];
      
        
        _nameLable.textColor=[UIColor redColor];
        _nameLable.font=[UIFont systemFontOfSize:14];
        _nameLable.numberOfLines=0;
       
        [self.contentView addSubview:_nameLable];
    }
    
    return self;
}

-(void)setImage:(UIImage *)img msg:(NSString *)msg
{
//    1发送 0接受
    if(_Send==0)
    {
    
        
        
        
        CGFloat textW = SCREEN_WIDTH-60*2-10-20;
        CGFloat textH=10+[msg boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        if(textH<27)
        {
            _nameLable.textAlignment=NSTextAlignmentRight;
            
        }
        _nameLable.numberOfLines=0;
         _headImage.frame=CGRectMake(XXWIDTH-70,10, 60, 60);
//        [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(-10);
//            make.top.equalTo(10);
//            make.width.equalTo(60);
//            make.height.equalTo(60);
//        }];
        _nameLable.frame=CGRectMake(60+10, 10,  textW, textH);
//        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_headImage.left).offset(-10);
//            make.top.equalTo(10);
//            make.width.equalTo(textW);
//            make.height.equalTo(textH);
//        }];
       
        _nameLable.text=msg;
       
       
        _headImage.image=img;
        
        if (textH<80) {
            self.cellHeight=80;
        }
        else
            self.cellHeight=textH;
    
    }
    else if(_Send==1)
    {
        _headImage.frame=CGRectMake(10,10, 60, 60);
        CGFloat textW = SCREEN_WIDTH-60*2-10-20;
        CGFloat textH=10+[msg boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
            _nameLable.frame=CGRectMake(60+10+20, 10,  textW, textH);
        _nameLable.numberOfLines=0;
        _nameLable.textAlignment=NSTextAlignmentLeft;
      
        
    _nameLable.text=msg;
   
        
    _headImage.image=img;
    if (textH<80) {
        self.cellHeight=80;
    }
    else
        self.cellHeight=textH;

    }

}
@end
