//
//  AccountTool.h
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  账号工具类
 */
@interface AccountTool : NSObject
/**
 *  登录用户
 */
@property(nonatomic,copy)NSString *loginUser;
/**
 *  登录密码
 */
@property(nonatomic,copy)NSString *loginPwd;

/**
 *  判断用户是否登录
 */
@property(nonatomic,assign)BOOL login;
/**
 *  注册用户
 */
@property(nonatomic,copy)NSString *registerUser;
/**
 *  注册密码
 */
@property(nonatomic,copy)NSString *registerPwd;
+(instancetype)shareAccount;
/**
 *  保存用户数据到沙盒
 */
-(void)saveAccount;
/**
 *  服务器域名
 */
@property(nonatomic,copy,readonly)NSString *domain;
/**
*  服务器Ip
*/
@property(nonatomic,copy,readonly)NSString *host;
/**
 *  端口号
 */
@property(nonatomic,assign,readonly)int port;
@end
