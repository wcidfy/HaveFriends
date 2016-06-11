//
//  ABCommonTools.h
//  AlipayBox
//
//  Created by tree on 3/14/15.
//  Copyright (c) 2015 AlipayBox. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  封装常见工具方法
 */
@interface ABCommonTools : NSObject


#pragma mark - 显示提示信息

/**
 *  在window上展示提示信息(1秒后消失)
 *
 *  @param instruction 提示信息
 */
+ (void)showInstrutions:(NSString *)instruction;

/**
 *  在view上展示提示信息(1秒后消失)
 *
 *  @param instruction 提示信息
 *  @param view 要展示信息的view
 */
+ (void)showInstrutions:(NSString *)instruction inView:(UIView *)view;




@end
