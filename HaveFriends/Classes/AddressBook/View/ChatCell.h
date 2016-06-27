//
//  ChatCell.h
//  HaveFriends
//
//  Created by lxx on 16/6/14.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ChatCell : UITableViewCell
/**
 *  头像
 */
@property(nonatomic,strong)UIImageView *headImage;
/**
 *  聊天内容
 */
@property(nonatomic,strong)UILabel *nameLable;

@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign)NSInteger Send;
-(void)setImage:(UIImage *)img msg:(NSString *)msg;
@end
