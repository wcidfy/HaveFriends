//
//  EditMessageController.h
//  HaveFriends
//
//  Created by lxx on 16/6/12.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditMessageController;
@protocol EditMessageControllerDelegate<NSObject>
-(void)editMessageController:(EditMessageController *)editVc didFinishSave:(id)sender;
@end
/**
 *  编辑个人信息
 */
@interface EditMessageController : UIViewController
/**
 *  接受上一个控制器的cell
 */
@property(nonatomic,strong)UITableViewCell *cell;

@property(nonatomic,weak)id<EditMessageControllerDelegate> delegate;
@end
