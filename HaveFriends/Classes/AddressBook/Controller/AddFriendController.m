//
//  AddFriendController.m
//  HaveFriends
//
//  Created by lxx on 16/6/13.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "AddFriendController.h"
#import "AddFriendView.h"
#import "AccountTool.h"
@interface AddFriendController ()
@property(nonatomic,strong)AddFriendView *addFriendView;

@end

@implementation AddFriendController
-(void)loadView
{
    [super loadView];
    _addFriendView=[[AddFriendView alloc]init];
    self.view=_addFriendView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [_addFriendView.enterButton addTarget:self action:@selector(enterButtonlClick) forControlEvents:UIControlEventTouchUpInside];
     [_addFriendView.cancelButton addTarget:self action:@selector(cancelButtonlClick) forControlEvents:UIControlEventTouchUpInside];

}
-(void)enterButtonlClick
{
    NSString *user=_addFriendView.textFild.text ;
    if([user isEqualToString:@""])
    {
        [self showMsg:@"请输入用户名"];
        return;

    
    }
    if ([user isEqualToString:[AccountTool shareAccount].loginUser]) {
        [self showMsg:@"不能添加自己为好友"];
        return;
    }
    //已经添加的好友无法再次添加
    XMPPJID *usejid=[XMPPJID jidWithUser:user domain:[AccountTool shareAccount].domain resource:nil];
       BOOL userExits= [[XMPPTool sharedXMPPTool].roserStorage userExistsWithJID:usejid xmppStream:[XMPPTool sharedXMPPTool].xmppStream];
    if(userExits)
    {
        [self showMsg:@"好友已经存在或已发送添加请求"];
        return;
    
    }
    //添加好友
    [[XMPPTool sharedXMPPTool].roster subscribePresenceToUser:usejid];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)cancelButtonlClick
{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showMsg:(NSString *)msg{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [av show];
}
@end
