//
//  ChatController.h
//  HaveFriends
//
//  Created by lxx on 16/6/13.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  聊天界面
 */
@interface ChatController : UIViewController
/**
 *  好友的JID
 */
@property(nonatomic,strong)XMPPJID *friendJid;
@property(nonatomic,copy)NSString *Title;

@end
