//
//  AddFriendView.h
//  HaveFriends
//
//  Created by lxx on 16/6/13.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  添加好友界面
 */
@interface AddFriendView : UIView
/**
 *  取消按钮
 */
@property(nonatomic,strong)UIButton *cancelButton;
/**
 *  确定按钮
 */
@property(nonatomic,strong)UIButton *enterButton;
/**
 *  title
 */
@property(nonatomic,strong)UILabel *titleLable;
/**
 *  文本框
 */
@property(nonatomic,strong)UITextField *textFild;

@end
