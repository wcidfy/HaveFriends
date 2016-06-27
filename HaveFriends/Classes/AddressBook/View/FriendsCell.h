//
//  FriendsCell.h
//  HaveFriends
//
//  Created by lxx on 16/6/15.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsCell : UITableViewCell
/**
 *  头像
 */
@property(nonatomic,strong)UIImageView *headImage;
/**
 *  聊天内容
 */
@property(nonatomic,strong)UILabel *nameLable;
/**
 *  状态
 */
@property(nonatomic,strong)UILabel *stateLable;
/**
 *  未读消息
 */
@property(nonatomic,strong)UIButton *unreadMessage;
-(void)setImage:(UIImage *)imageStr nameStr:(NSString *)nameStr stateStr:(NSString *)stateStr buttonStr:(NSNumber *)buttonStr;
@end
