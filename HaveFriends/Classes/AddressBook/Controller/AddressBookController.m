//
//  AddressBookController.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "AddressBookController.h"
#import "XMPPTool.h"
#import "AddressBookView.h"
#import "AddFriendController.h"
#import "ChatController.h"
#import "FriendsCell.h"
#import "BKTableView.h"
#import "AddressAdapter.h"
@interface AddressBookController ()<BKTableViewAdapterDelegate,NSFetchedResultsControllerDelegate>
{
    NSManagedObjectContext *_managedObjectContext;
}

@property(nonatomic,strong)AddressBookView *addressBookView;
@property(nonatomic,strong)BKTableView *tableView;
@property(nonatomic,strong)AddressAdapter *addressAdapter;
@property(nonatomic,strong)NSFetchedResultsController *resultContr;


@end

@implementation AddressBookController
-(void)loadView
{
    [super loadView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    _addressBookView=[[AddressBookView alloc]init];
    self.view=_addressBookView;
    self.tableView=_addressBookView.tableView;
//    self.tableView.delegate=self;
//    self.tableView.dataSource=self;
//    [self.tableView setRowHeight:60];
    _addressAdapter=[[AddressAdapter alloc]init];
    _addressAdapter.delegate=self;
    [self.tableView setAdapter:_addressAdapter];
   
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadUser1];
    [_addressBookView.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //3.2执行
    [self.resultContr performFetch:NULL];
    _addressAdapter.dataArray=(NSMutableArray *)self.resultContr.fetchedObjects;
     [self.tableView setAdapter:_addressAdapter];
}
-(void)cancelButtonClick
{
    AddFriendController *add=[[AddFriendController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:add animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}



- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    //1上下文关联XMPPRoster.sqlite文件
   _managedObjectContext=[XMPPTool sharedXMPPTool].roserStorage.mainThreadManagedObjectContext;
       return _managedObjectContext;
}

- (NSFetchedResultsController *)resultContr {
    if (_resultContr != nil) {
        return _resultContr;
    }else{
    //显示好友数据 （保存XMPPRoster.sqlite）
    
    //1上下文关联XMPPRoster.sqlite文件
//     NSManagedObjectContext *roserContext=[XMPPTool sharedXMPPTool].roserStorage.mainThreadManagedObjectContext;
        
       
    //2.Request 请求查询哪张表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    //设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sort];
    
    
    //过滤
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"subscription != %@",@"none"];
    request.predicate = pre;
    
    _resultContr = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _resultContr.delegate = self;
       
     
    return _resultContr;
    }


}
#pragma mark table select点击
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    XMPPUserCoreDataStorageObject *user=self.resultContr.fetchedObjects[indexPath.row];
//
//    ChatController *chat=[[ChatController alloc]init];
//    self.hidesBottomBarWhenPushed=YES;
//    chat.friendJid=user.jid;
//    chat.Title=user.nickname;
//    [self.navigationController pushViewController:chat animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
//
//}
-(void)didTableViewCellSelected:(UITableViewCell *)aCellData
{
    XXLog(@"123213123123");
}
-(void)didTableViewSelected:(NSInteger)index
{
    XXLog(@"dasdsadasdasd");
    XMPPUserCoreDataStorageObject *user=self.resultContr.fetchedObjects[index];
    
    ChatController *chat=[[ChatController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    chat.friendJid=user.jid;
    chat.Title=user.nickname;
    [self.navigationController pushViewController:chat animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}



//#pragma mark table 删除
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //获取对应好友
//    XMPPUserCoreDataStorageObject *user=self.resultContr.fetchedObjects[indexPath.row];
//    if (editingStyle==UITableViewCellEditingStyleDelete) {
//        //删除好友
//            [[XMPPTool sharedXMPPTool].roster removeUser:user.jid];
////               [self.tableView reloadData];
//        [self.tableView refreshTableView];
//    }
//}
#pragma mark 结果控制器的代理
#pragma mark 数据库内容改变
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    XXLog(@"%@",[NSThread currentThread]);
    [self.tableView refreshTableView];
}
@end
