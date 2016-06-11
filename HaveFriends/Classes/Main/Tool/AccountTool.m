//
//  AccountTool.m
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "AccountTool.h"
#define loginUserKey @"loginUser"
#define loginPwdKey @"loginPwd"
#define loginKey @"login"
static NSString *domain=@"127.0.0.1";
static NSString *host=@"127.0.0.1";
static int port=5222;

@implementation AccountTool
+(instancetype)shareAccount
{

    return [[self alloc]init];
}
#pragma mark 分配内存创建对象
+(instancetype)allocWithZone:(struct _NSZone *)zone
{

    static AccountTool *account;
//    static dispatch
    if (account==nil) {
        account=[super allocWithZone:zone];
        //从沙盒获取上次的用户登录信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        account.loginUser = [defaults objectForKey:@"loginUser"];
        account.loginPwd = [defaults objectForKey:@"loginPwd"];
        account.login = [defaults boolForKey:loginKey];
    }
    return account;
}
-(void)saveAccount
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.loginUser forKey:loginUserKey];
    [defaults setObject:self.loginPwd forKey:loginPwdKey];
    [defaults setBool:self.login forKey:loginKey];


}
-(NSString *)domain
{

    return domain;
}
-(NSString *)host
{
    
    return host;
}
-(int)port
{

    return port;
}
@end
