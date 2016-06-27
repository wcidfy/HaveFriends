//
//  PersonAdapter.m
//  HaveFriends
//
//  Created by lxx on 16/6/19.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "PersonAdapter.h"
#import "AccountTool.h"
#import "XMPPUser.h"
@interface PersonAdapter()
{
      UIImageView *imHead;

}
@end
@implementation PersonAdapter
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

     return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section==0) {
        return 3;
    }else
        return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 80;
        }
    }
    
    return 50;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell=REUSED_CELL(tableView, UITableViewCell);
    
    static NSString *cellId=@"personCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        
    }
   
    
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text =@[@"头像",@"昵称",@"微信号"][indexPath.row];
            
            
            cell.detailTextLabel.text =@[@"",[XMPPUser shareUser].nickname,[AccountTool shareAccount].loginUser][indexPath.row];
            switch (indexPath.row) {
                case 0:
                    imHead=[[UIImageView alloc]init];
                    imHead.frame=CGRectMake(kScreenWidth-90, 10, 60, 60);
                    //显示头像用户名
                    if([XMPPUser shareUser].headPhoto==nil)
                    {
                        imHead.image=[UIImage imageNamed:@"imageHead"];
                        [cell.contentView addSubview:imHead];
                    }
                    else{
                        imHead.image=[UIImage imageWithData:[XMPPUser shareUser].headPhoto];
                        [cell.contentView addSubview:imHead];
                    }
                    
                    cell.tag=CellTypeChangeHead;
                    break;
                case 1:
                    cell.tag=CellTypeJumpController;
                    break;
                case 2:
                    cell.tag=CellTypeNotDo;
                    break;
            }
            
            break;
        case 1:
            cell.textLabel.text =@[@"公司",@"部门",@"职位",@"电话",@"邮件"][indexPath.row];
            cell.detailTextLabel.text =@[[XMPPUser shareUser].orgName,[XMPPUser shareUser].orgUnits,[XMPPUser shareUser].title,[XMPPUser shareUser].note,[XMPPUser shareUser].mailer][indexPath.row];
            cell.tag=CellTypeJumpController;
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell= [tableView cellForRowAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTableViewCellSelected:)]) {
        [self.delegate didTableViewCellSelected:cell];
    }
}
@end
