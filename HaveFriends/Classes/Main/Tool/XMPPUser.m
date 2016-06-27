//
//  XMPPUser.m
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "XMPPUser.h"
#define HeadPhotoKey @"headPhoto"
#define nickNameKey @"nickname"
#define orgNameKey @"orgName"
#define  orgUnitsKey @"orgUnits"
#define titleKey @"title"
#define noteKey @"note"
#define mailerKey @"mailer"
@implementation XMPPUser
+(instancetype)shareUser
{
    return [[self alloc]init];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static XMPPUser *user;
    if (user==nil) {
        user=[super allocWithZone:zone];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        user.headPhoto=[defaults objectForKey:HeadPhotoKey];
        user.nickname=[defaults objectForKey:nickNameKey];
        user.orgName=[defaults objectForKey:orgNameKey];
        user.orgUnits=[defaults objectForKey:orgUnitsKey];
        user.title=[defaults objectForKey:titleKey];
        user.note=[defaults objectForKey:nickNameKey];
        user.mailer=[defaults objectForKey:mailerKey];



        
    }
    return user;
}

-(void)saveUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.headPhoto forKey:HeadPhotoKey];
    [defaults setObject:self.nickname forKey:nickNameKey];
    [defaults setObject:self.orgName forKey:orgNameKey];
    [defaults setObject:self.orgUnits forKey:orgUnitsKey];
    [defaults setObject:self.title forKey:titleKey];
    [defaults setObject:self.note forKey:noteKey];
    [defaults setObject:self.mailer forKey:mailerKey];

    
    
}

@end
