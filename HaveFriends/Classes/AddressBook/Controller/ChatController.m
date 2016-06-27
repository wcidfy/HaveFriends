//
//  ChatController.m
//  HaveFriends
//
//  Created by lxx on 16/6/13.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "ChatController.h"
#import "ChatView.h"
#import "ChatCell.h"
#import "AccountTool.h"
#import "ChatAdapter.h"
@interface ChatController ()<NSFetchedResultsControllerDelegate,UITextViewDelegate>
{
    NSFetchedResultsController *_resultContr;

}
@property(nonatomic,strong)ChatView *chatView;
@property(nonatomic,strong)BKTableView *tableView;
@property(nonatomic,strong)UIView *grayView;
@property(nonatomic,strong)UITextView *inPutTextView;
@property(nonatomic,strong)ChatAdapter *chatAdapter;
@end

@implementation ChatController
-(void)loadView
{
    [super loadView];
    _chatView=[[ChatView alloc]init];
    self.view=_chatView;
    self.tableView= _chatView.tableView;
    
    _chatAdapter=[[ChatAdapter alloc]init];
    _chatAdapter.FriendJid=_friendJid;
//     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView SetSeparatorStyle];
    [self.tableView setAdapter:_chatAdapter];
    
    self.grayView= _chatView.inputView;
    self.inPutTextView=_chatView.inputTextView;
    [self.inPutTextView setDelegate:self];
    _chatView.titleLable.text=self.Title;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [_chatView.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self loadDate];
    [_chatView.sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tag=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeKeyborad)];
    [self.view addGestureRecognizer:tag];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    //进入聊天界面默认滚动到table底部
//    if (_resultContr.fetchedObjects.count>1) {
////        NSIndexPath *lastIndex=[NSIndexPath indexPathForRow:_resultContr.fetchedObjects.count-1 inSection:0];
////        [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        [self.tableView ScrollBotton:_resultContr.fetchedObjects];
//    }
    
   
}
#pragma mark 移除键盘
-(void)removeKeyborad
{
    [_chatView.inputTextView resignFirstResponder];

}
#pragma mark -键盘的通知
#pragma mark 键盘将显示
-(void)kbWillShow:(NSNotification *)noti{
    //显示的时候改变bottomContraint
    
    // 获取键盘高度
    NSLog(@"%@",noti.userInfo);
    CGFloat kbHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.grayView.y=Height-kbHeight-49;
     XXLog(@"  %@",NSStringFromCGRect(self.grayView.frame));
//    [UIView animateWithDuration:0.5 animations:^{
//        CGRect zz=self.grayView.frame;
//       zz.origin.y=Height-kbHeight-49;
//        self.grayView.frame=zz;
//        XXLog(@"%@  %@",NSStringFromCGRect(zz),NSStringFromCGRect(self.grayView.frame));
//    }];
   
    
    
        if(_resultContr.fetchedObjects.count>0)
        {
            self.tableView.y=64;

            [self.tableView ScrollBotton:_resultContr.fetchedObjects];
        }

    
   
    
   
   
}
#pragma mark 键盘将隐藏
-(void)kbWillHide:(NSNotification *)noti
{
    self.grayView.y=self.view.bounds.size.height-49;
    self.tableView.y=64;
}
#pragma mark 加载数据库 聊天信息
-(void)loadDate
{
//    1.上下文
    NSManagedObjectContext *manageObject=[[XMPPTool sharedXMPPTool].msgArchivingStorage mainThreadManagedObjectContext];
//    2。查询请求
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    
//    过滤 （当前用户的）
    NSString *userJid=[XMPPTool sharedXMPPTool].xmppStream.myJID.bare;
    NSPredicate *per=[NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",userJid,self.friendJid.bare];
    request.predicate=per;
    
//    设置时间排序
    NSSortDescriptor *timeSort=[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors=@[timeSort];
    //    3.执行请求
    _resultContr=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:manageObject sectionNameKeyPath:nil cacheName:nil];
    _resultContr.delegate=self;
    NSError *err=nil;
    [_resultContr performFetch:&err];
    XXLog(@"XXXXXXXXX%@",_resultContr.fetchedObjects);
    _chatAdapter.dataArray=(NSMutableArray *)_resultContr.fetchedObjects;


}
#pragma mark 结果控制器
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    XXLog(@"chatController");
      _chatAdapter.dataArray=(NSMutableArray *)_resultContr.fetchedObjects;
    [self.tableView refreshTableView];
//    NSIndexPath *lastIndex=[NSIndexPath indexPathForRow:_resultContr.fetchedObjects.count-1 inSection:0];
//    [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self.tableView ScrollBotton:_resultContr.fetchedObjects];


}
-(void)cancelButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)sendButtonClick
{
    if([_inPutTextView.text isEqualToString:@""])
    {
        return;
    }else
    {
    // 发送聊天数据
    XMPPMessage *msg=[[XMPPMessage alloc]initWithType:@"chat" to:self.friendJid];
    [msg addBody:_inPutTextView.text];
    [[XMPPTool sharedXMPPTool].xmppStream sendElement:msg];
        _inPutTextView.text=nil;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self.view endEditing:YES];
}
#pragma mark 点击键盘发送按钮
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
       
        // 发送聊天数据
        XMPPMessage *msg=[[XMPPMessage alloc]initWithType:@"chat" to:self.friendJid];
        [msg addBody:_inPutTextView.text];
        [[XMPPTool sharedXMPPTool].xmppStream sendElement:msg];
        _inPutTextView.text=nil;
        return NO;
        
    }
    
        return YES;
}

@end
