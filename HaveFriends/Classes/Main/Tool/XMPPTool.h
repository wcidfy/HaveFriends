//
//  XMPPTool.h
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

#import "Singleton.h"
typedef enum
{
    XMPPResultTypeLoginSucess,//登录成功
    XMPPResultTypeLoginFailure,//登录失败
    XMPPResultTypeRegisterSucess,
    XMPPResultTypeRegisterFailure
}XMPPResultType;
typedef void(^XMPPResultBlock) (XMPPResultType);
/**
 *  xmpp 工具类 登录注销
 */
@interface XMPPTool : NSObject
singleton_interface(XMPPTool);

/**
 *  //与服务器交互核心类
 */
@property(strong,nonatomic,readonly)XMPPStream *xmppStream;
/**
 *  电子名片模块
 */
@property(strong,nonatomic,readonly)XMPPvCardTempModule* vCard;
/**
 *  电子名片数据存储
 */
@property(strong,nonatomic,readonly)XMPPvCardCoreDataStorage *vCardStorage;


/**
 *  电子名片头像模块
 */
@property(strong,nonatomic,readonly)XMPPvCardAvatarModule *avatar;

/**
 *  花名册数据存储
 */
@property(strong,nonatomic,readonly)XMPPRosterCoreDataStorage* roserStorage;
/**
 *  花名册
 */
@property(strong,nonatomic,readonly)XMPPRoster *roster;

@property(strong,nonatomic,readonly)XMPPMessageArchiving *msgArchiving;
@property(strong,nonatomic,readonly)XMPPMessageArchivingCoreDataStorage *msgArchivingStorage;

/**
 *  标识 连接服务器 到底是 "登录连接"还是 “注册连接”
 *  NO 代表登录操作
 *  YES 代表注册操作
 */
@property(assign,nonatomic,getter=isRegisterOperation)BOOL registerOperation;
/**
 *  XMPP用户登录
 */
-(void)xmppLogin:(XMPPResultBlock)resultBlock;
/**
 *  XMPP用户注册
 */
-(void)xmppRegister:(XMPPResultBlock)resultBlock;
/**
 *  注销
 */
-(void)xmppLogout;

/**
 *  释放资源
 */
-(void)releaseStream;
@end
