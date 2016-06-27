//
//  MeController.m
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "MeController.h"
#import "MeView.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "AccountTool.h"
#import "XMPPTool.h"
#import "CardCell.h"
#import "XMPPvCardTemp.h"
#import "PersonController.h"
#import "XMPPUser.h"
@interface MeController ()<UITableViewDelegate,UITableViewDataSource,PersonControllerDelegate>
{
    NSData *headDate;
    UIImage *image;

}
@property(nonatomic,strong)MeView *meView;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MeController
-(void)loadView
{
    [super loadView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _meView=[[MeView alloc]init];

    
    self.view=_meView;
    self.tableView=_meView.tableView;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setRowHeight:80];
    self.tableView.tableFooterView=[[UIView alloc]init];
    [_meView.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
   

    
}

-(void)cancelClick
{
//    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    [[XMPPTool sharedXMPPTool]  xmppLogout];
    [AccountTool shareAccount].login=NO;
    [[AccountTool shareAccount] saveAccount];

    [XMPPUser shareUser].nickname=@"";
    [XMPPUser shareUser].orgName=@"";
    [XMPPUser shareUser].headPhoto=nil;
    [XMPPUser shareUser].orgUnits=@"";
    [XMPPUser shareUser].title=@"";
    [XMPPUser shareUser].note=@"";
    [XMPPUser shareUser].mailer=@"";
    [[XMPPUser shareUser] saveUser];

    [self changeToLogin];
}
-(void)changeToLogin
{
//    dispatch_async(dispatch_get_main_queue(), ^{
    
        LoginController *login=[[LoginController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController=login;
        [AccountTool shareAccount].login=NO;
        [AccountTool shareAccount].loginUser=nil;
        [AccountTool shareAccount].loginPwd=nil;
        [[AccountTool shareAccount]saveAccount];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]);
//    });
    
}
#pragma mark table代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CardCell *cell=[]
    static NSString *cellCard=@"CardCell";
    CardCell *cell=[tableView dequeueReusableCellWithIdentifier:cellCard];
    if (cell==nil) {
        cell=[[CardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellCard];
    }
    //显示头像用户名
    if([XMPPUser shareUser].headPhoto==nil)
    {
        cell.headImage.image=[UIImage imageNamed:@"imageHead"];
    }
    else{
    cell.headImage.image=[UIImage imageWithData:[XMPPUser shareUser].headPhoto];
    }
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.nameLable.text=[NSString stringWithFormat:@"微信号： %@",[AccountTool shareAccount].loginUser];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    PersonController *person=[[PersonController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    person.delegate=self;
    [self.navigationController pushViewController:person animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}
#pragma mark 在。h中添加刷新方法 pop到指定界面调用
-(void)refreshTable
{

    [self.tableView reloadData];
}

#pragma mark personcontroller 代理方法  刷新table

-(void)personController:(PersonController *)personVc didFinishRefresh:(id)sender
{
 
    [self.tableView reloadData];
    XXLog(@"刷新table");
}
@end
