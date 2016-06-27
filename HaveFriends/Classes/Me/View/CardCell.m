//
//  CardCell.m
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImage=[[UIImageView alloc]init];
        _headImage.layer.masksToBounds=YES;
        _headImage.layer.cornerRadius=30;
        [self.contentView addSubview:_headImage];
        _nameLable=[[UILabel alloc]init];
        _nameLable.textColor=[UIColor redColor];
        [self.contentView addSubview:_nameLable];
    }

    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _headImage.frame=CGRectMake(20,10, 60, 60);
    _nameLable.frame=CGRectMake(60+20+20, 50, 200, 20);
    
}
@end
