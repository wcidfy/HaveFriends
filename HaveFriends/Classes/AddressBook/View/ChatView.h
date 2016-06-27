//
//  ChatView.h
//  HaveFriends
//
//  Created by lxx on 16/6/13.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  添加好友界面
 */
@interface ChatView : UIView
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

@property(nonatomic,strong)BKTableView *tableView;
/**
 *  输入框所在view
 */
@property(nonatomic,strong)UIView *inputView;

/**
 *  输入框
 */
@property(nonatomic,strong)UITextView *inputTextView;

/**
 *  发送按钮
 */
@property(nonatomic,strong)UIButton  *sendButton;
@end
