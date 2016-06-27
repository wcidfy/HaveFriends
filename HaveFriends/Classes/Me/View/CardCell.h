//
//  CardCell.h
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  名片cell
 */
@interface CardCell : UITableViewCell
/**
 *  头像
 */
@property(nonatomic,strong)UIImageView *headImage;
/**
 *  用户名
 */
@property(nonatomic,strong)UILabel *nameLable;

@end
