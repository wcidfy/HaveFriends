//
//  LoginView.h
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  登录view
 */
@interface LoginView : UIView
/**
 *头像
 */
@property(nonatomic,strong)UIImageView *headImage;
/**
 *  登录用户名
 */
@property(nonatomic,strong)UITextField *loginName;
/**
 *  登录密码
 */
@property(nonatomic,strong)UITextField *loginPwd;
/**
 *  登录
 */
@property(nonatomic,strong)UIButton *loginCancel;
/**
 *  无法登录
 */
@property(nonatomic,strong)UIButton *loginNoCancel;
/**
 *  新用户
 */
@property(nonatomic,strong)UIButton *loginNewUser;

@end
