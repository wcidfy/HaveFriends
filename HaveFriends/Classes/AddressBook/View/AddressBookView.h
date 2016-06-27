//
//  AddressBookView.h
//  HaveFriends
//
//  Created by lxx on 16/6/13.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKTableView.h"

/**
 *  通讯录view
 */
@interface AddressBookView : UIView
/**
 *  注销按钮
 */
@property(nonatomic,strong)UIButton *cancelButton;
/**
 *  title
 */
@property(nonatomic,strong)UILabel *titleLable;

@property(nonatomic,strong)BKTableView *tableView;

@end
