//
//  PersonView.h
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKTableView.h"
@interface PersonView : UIView
/**
 *  取消按钮
 */
@property(nonatomic,strong)UIButton *cancelButton;
/**
 *  title
 */
@property(nonatomic,strong)UILabel *titleLable;

@property(nonatomic,strong)BKTableView *tableView;

@end
