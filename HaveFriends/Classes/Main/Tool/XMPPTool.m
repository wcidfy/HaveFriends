//
//  XMPPTool.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "XMPPTool.h"
#import "AccountTool.h"
@interface XMPPTool ()<XMPPStreamDelegate>
{
  
    XMPPResultBlock _resultBlock;
}
/**
 *  1.初始化XMPPStream
 */
-(void)setupStream;

/**
 *  2.连接服务器(传一个jid)
 */
-(void)connectToHost;

/**
 *  3.连接成功，接着发送密码
 */
-(void)sendPwdToHost;

/**
 *  4.发送一个 "在线消息" 给服务器
 */
-(void)sendOnLine;
@end

@implementation XMPPTool
singleton_implementation(XMPPTool);
#pragma mark 1初始化xmppstream
-(void)setupStream
{
    //1 创建对象
    _xmppStream=[[XMPPStream alloc]init];
   
    
  
    //添加电子名片模块
    _vCardStorage=[XMPPvCardCoreDataStorage sharedInstance];
    _vCard=[[XMPPvCardTempModule alloc]initWithvCardStorage:_vCardStorage];
    //激活
    [_vCard activate:_xmppStream];
    
    //2添加头像模块
    _avatar=[[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_vCard];
    //激活
    [_avatar activate:_xmppStream];
    
    
    //3添加花名册
    //花名册数据存储
    _roserStorage=[XMPPRosterCoreDataStorage sharedInstance];
    //花名册对象
    _roster=[[XMPPRoster alloc]initWithRosterStorage:_roserStorage];
    //    激活
    [_roster activate:_xmppStream];
    
    // 4.添加 "消息" 模块
    _msgArchivingStorage = [[XMPPMessageArchivingCoreDataStorage alloc] init];
    _msgArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_msgArchivingStorage];
    [_msgArchiving activate:_xmppStream];
    
    
     [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
}
#pragma mark 释放资源
-(void)releaseStream
{
// 移除代理
    [_xmppStream removeDelegate:self];
    
//    取消模块
    [_avatar deactivate];
    [_vCard deactivate];
    [_roster deactivate];
    [_msgArchiving deactivate];
//    断开连接
    [_xmppStream disconnect];
//    清空资源

    _vCard=nil;
    _avatar=nil;
    _vCardStorage=nil;
    _roster=nil;
    _roserStorage=nil;
    _msgArchiving=nil;
    _msgArchivingStorage=nil;
    _xmppStream=nil;
}
#pragma mark 2连接服务器（传一个jid）
-(void)connectToHost
{
    if (!_xmppStream) {
        [self setupStream];
    }
    // 1.设置jid
    AccountTool *account=[AccountTool shareAccount];
    if (self.isRegisterOperation) {
        NSString *registerUser=account.registerUser;
          XMPPJID *myjid=[XMPPJID jidWithUser:registerUser domain:account.domain resource:nil];
          _xmppStream.myJID=myjid;
    }else{
        NSString *user=account.loginUser;
    XMPPJID *myjid=[XMPPJID jidWithUser:user domain:account.domain resource:nil];
          _xmppStream.myJID=myjid;
    }
  
    //  2.设置主机地址
    _xmppStream.hostName=account.host;
    //   3 设置端口号
    _xmppStream.hostPort=account.port;
    //    4发起连接
    NSError *error=nil;
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        XXLog(@"%@",error);
       
        
    }else
    {
        XXLog( @"发送连接成功");
        
    }
}
#pragma mark 3 连接成功 发送密码
-(void)sendPwdToHost
{
    NSError *error=nil;
   NSString *pwd= [AccountTool shareAccount].loginPwd;
    [_xmppStream authenticateWithPassword:pwd error:&error];
    if (error) {
        XXLog(@"%@",error);
        
    }else
    {
        XXLog( @"发起连接成功");
        
    }
}
#pragma mark 发送一个在线消息给服务器
-(void)sendOnLine
{
    XMPPPresence *presence=[XMPPPresence presence];
    XXLog(@"%@",presence);
    [_xmppStream sendElement:presence];
    
}
#pragma mark 发送一个离线消息
-(void)sendOffLine
{
    XMPPPresence *presence=[XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:presence];
    
}


-(void)dealloc
{
    [self releaseStream];
   
}



#pragma mark xmppstream的代理
#pragma mark 连接建立成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    XXLog(@"%s",__func__);
    if(self.isRegisterOperation)
    {
//    注册
        NSError *error=nil;
        NSString *pwd=[AccountTool shareAccount].registerPwd;
        [_xmppStream registerWithPassword:pwd error:&error];
        if (error) {
            XXLog(@"%@",error);
        }
    }else
    {
//        登录
    [self sendPwdToHost];
    }
    
}
#pragma mark 断开连接

-(void)xmppStreamDidSendClosingStreamStanza:(XMPPStream *)sender
{
    XXLog(@"%s",__func__);
    
}
#pragma mark  登录成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    XXLog(@"%s",__func__);
    [self sendOnLine];
    //回调resultBlock (告诉 logincontroller)
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginSucess);
    }
    
}
#pragma mark 登录失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    XXLog(@"%s %@",__func__,error);
    //回调resultBlock (告诉 logincontroller)
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
    
    
}
#pragma mark 注册成功
-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    XXLog(@"%s",__func__);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterSucess);
    }
}
#pragma mark 注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    XXLog(@"%s %@",__func__,error);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
 
}
#pragma mark 用户登录 公共方法
-(void)xmppLogin:(XMPPResultBlock)resultBlock
{
    //去掉以前的连接
    [_xmppStream disconnect];
    _resultBlock=resultBlock;
    [self connectToHost];
    
    
}
#pragma mark 注册
-(void)xmppRegister:(XMPPResultBlock)resultBlock
{
    //去掉以前的连接
    [_xmppStream disconnect];
    _resultBlock=resultBlock;
    [self connectToHost];
    
    
}

#pragma mark 注销
-(void)xmppLogout
{
  
    //    1.发送离线消息
    [self sendOffLine];
    //    2.断开连接
    [_xmppStream disconnect];
    
    
}

@end
