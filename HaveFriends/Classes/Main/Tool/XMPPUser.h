//
//  XMPPUser.h
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  个人信息
 */
@interface XMPPUser : NSObject
//NSString *photo=[ud objectForKey:@"headPhoto"];
//NSString *nickname=[ud objectForKey:@"nickname"];
//NSString *orgName=[ud objectForKey:@"orgName"];
//NSString *orgUnits=[ud objectForKey:@"orgUnits"];
//NSString *title=[ud objectForKey:@"title"];
//NSString *note=[ud objectForKey:@"note"];
//NSString *mailer=[ud objectForKey:@"mailer"];
/**
 *  头像
 */
@property(nonatomic,copy)NSData *headPhoto;
/**
 *  昵称
 */
@property(nonatomic,copy)NSString *nickname;
/**
 *  公司
 */
@property(nonatomic,copy)NSString *orgName;
/**
 *  部门
 */
@property(nonatomic,copy)NSString *orgUnits;
/**
 *  职位
 */
@property(nonatomic,copy)NSString *title;
/**
 *  电话
 */
@property(nonatomic,copy)NSString *note;
/**
 *  邮箱
 */
@property(nonatomic,copy)NSString *mailer;
+(instancetype)shareUser;
-(void)saveUser;
@end
