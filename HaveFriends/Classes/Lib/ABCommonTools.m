//
//  ABCommonTools.m
//  AlipayBox
//
//  Created by tree on 3/14/15.
//  Copyright (c) 2015 AlipayBox. All rights reserved.
//

#import "ABCommonTools.h"



@implementation ABCommonTools


#pragma mark - 显示提示信息

+ (void)showInstrutions:(NSString *)instruction {
    [self showInstrutions:instruction inView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showInstrutions:(NSString *)instruction inView:(UIView *)view {
    // 展示字符串为空，不展示
    if (!instruction || instruction.length == 0) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = instruction;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    // 防止弹出框阻塞主线程(1秒后消失    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
    
    
}







@end
