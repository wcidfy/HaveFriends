//
//  AddressAdapter.m
//  HaveFriends
//
//  Created by lxx on 16/6/19.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "AddressAdapter.h"
#import "FriendsCell.h"
@interface AddressAdapter()
{

}
@end

@implementation AddressAdapter
#pragma mark tableView 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellId=@"addressBook";
//    FriendsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell==nil) {
//        cell=[[FriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
    FriendsCell *cell=REUSED_CELL(tableView, FriendsCell);
    //获取对应好友
    //    XMPPUserCoreDataStorageObject *user=self.userArray[indexPath.row];
    
    XMPPUserCoreDataStorageObject *user=self.dataArray[indexPath.row];
    NSLog(@"SSSS   %@",user);
    
    
    //    kvo
    //    [user addObserver:self forKeyPath:@"sectionNum" options:NSKeyValueObservingOptionNew context:nil];
    // 0:在线 1：离开 2：离线
    NSString *state=nil;
    switch ([user.sectionNum integerValue]) {
        case 0:
            state=@"在线";
            break;
        case 1:
            state=@"离开";
            break;
        case 2:
            state=@"离线";
            break;
        default:
            state=@"见鬼了";
            break;
    }
    //头像
    
    //从服务器获取
    NSData *date=[[XMPPTool sharedXMPPTool].avatar photoDataForJID:user.jid];
    
    [cell setImage:[UIImage imageWithData:date] nameStr:user.displayName stateStr:state buttonStr:user.sectionNum];
    
    if ([[XMPPTool sharedXMPPTool].avatar photoDataForJID:user.jid]==nil) {
        [cell setImage:[UIImage imageNamed:@"imageHead"] nameStr:user.displayName stateStr:state buttonStr:user.sectionNum];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didTableViewSelected:)]) {
        [self.delegate didTableViewSelected:indexPath.row];
    }


}


#pragma mark table 删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取对应好友
    XMPPUserCoreDataStorageObject *user=self.dataArray[indexPath.row];
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //删除好友
        [[XMPPTool sharedXMPPTool].roster removeUser:user.jid];
        //               [self.tableView reloadData];
        UITableView *tableview=tableView;
        [tableview reloadData];
    }
}
@end
