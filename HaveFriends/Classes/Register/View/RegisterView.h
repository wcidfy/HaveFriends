//
//  RegisterView.h
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  注册view
 */
@interface RegisterView : UIView
/**
 *  取消按钮
 */
@property(nonatomic,strong)UIButton *cancelButton;
/**
 *  注册用户名
 */
@property(nonatomic,strong)UITextField *registerName;
/**
 *  注册密码
 */
@property(nonatomic,strong)UITextField *registerPwd;
/**
 *  注册按钮
 */
@property(nonatomic,strong)UIButton *registerButton;

@end
