//
//  ChatAdapter.m
//  HaveFriends
//
//  Created by lxx on 16/6/20.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "ChatAdapter.h"
#import "ChatCell.h"
@implementation ChatAdapter
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
    ChatCell *cell=REUSED_CELL(tableView, ChatCell);
//    static NSString *cellId=@"cellMessage";
//    ChatCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
//    //    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell==nil) {
//        cell=[[ChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        
//    }
    XMPPMessageArchiving_Message_CoreDataObject *object=self.dataArray[indexPath.row];
    XXLog(@"cdsfsdfdsfdsfdsf  %@",object);
    if([object.outgoing integerValue] ==1)
    {
        cell.Send=1;
        NSData *date= [[XMPPTool sharedXMPPTool].avatar photoDataForJID:[XMPPTool sharedXMPPTool].xmppStream.myJID];
        if(date==nil)
        {
            
            [cell setImage:[UIImage imageNamed:@"imageHead"] msg:object.body];
        }else
        {
            [cell setImage:[UIImage imageWithData:date] msg:object.body];
            
        }
        [tableView setRowHeight:cell.cellHeight];
        
    }else{
        cell.Send=0;
        NSData *date= [[XMPPTool sharedXMPPTool].avatar photoDataForJID:_FriendJid];
        if(date==nil)
        {
            
            [cell setImage:[UIImage imageNamed:@"imageHead"] msg:object.body];
        }else
        {
            [cell setImage:[UIImage imageWithData:date] msg:object.body];
            
        }
        [tableView setRowHeight:cell.cellHeight];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}
@end
