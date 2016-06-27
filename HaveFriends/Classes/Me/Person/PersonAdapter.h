//
//  PersonAdapter.h
//  HaveFriends
//
//  Created by lxx on 16/6/19.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "BKTableViewAdapter.h"

@interface PersonAdapter : BKTableViewAdapter
typedef NS_ENUM(NSInteger,CellType)
{
    CellTypeChangeHead,//换头像
    CellTypeJumpController ,//跳控制器
    CellTypeNotDo//不࿆做࿆任࿆何࿆操࿆作࿆
    
};
@end
