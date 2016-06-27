//
//  PersonController.h
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonController;
@protocol PersonControllerDelegate<NSObject>
-(void)personController:(PersonController *)personVc didFinishRefresh:(id)sender;

@end

/**
 *  个人信息界面
 */
@interface PersonController : UIViewController

//typedef NS_ENUM(NSInteger,CellType)
//{
//    CellTypeChangeHead,//换头像
//    CellTypeJumpController ,//跳控制器
//    CellTypeNotDo//不࿆做࿆任࿆何࿆操࿆作࿆
//
//};

@property(nonatomic,weak)id<PersonControllerDelegate>delegate;
@end
