//
//  ChatAdapter.h
//  HaveFriends
//
//  Created by lxx on 16/6/20.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "BKTableViewAdapter.h"

@interface ChatAdapter : BKTableViewAdapter
@property(nonatomic,strong)XMPPJID *FriendJid;
@end
