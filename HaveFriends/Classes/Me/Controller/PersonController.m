//
//  PersonController.m
//  HaveFriends
//
//  Created by lxx on 16/6/11.
//  Copyright © 2016年 lxx. All rights reserved.
//
#import "PersonController.h"
#import "PersonView.h"
#import "AccountTool.h"
#import "XMPPUser.h"
#import "XMPPvCardTemp.h"
#import "XMPPTool.h"
#import "EditMessageController.h"
#import "MeController.h"
#import "PersonAdapter.h"
#import "BKTableViewAdapter.h"
@interface PersonController ()<BKTableViewAdapterDelegate,EditMessageControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *imHead;
   
}
@property(nonatomic,strong)PersonView *personView;
@property(nonatomic,strong)BKTableView *tableView;
@property(nonatomic,strong)PersonAdapter *personAdapter;


@end

@implementation PersonController
-(void)loadView
{
    [super loadView];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _personView=[[PersonView alloc]init];
    self.view=_personView;
    self.tableView=_personView.tableView;
    
    _personAdapter=[[PersonAdapter alloc]init];
    _personAdapter.delegate=self;
    [self.tableView setAdapter:_personAdapter];
    
    


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
   
    [self buttonClicks];

   
}
-(void)buttonClicks
{
    [_personView.cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark 取消按钮
-(void)cancelClick:(id)sender
{
    if([self.delegate respondsToSelector:@selector(personController:didFinishRefresh:)])
    {
        [self.delegate personController:self didFinishRefresh:sender];
    
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if([controller isKindOfClass:[MeController class]])
        {
        
            MeController *me=(MeController*)controller;
#pragma mark 刷新table （刷新头像）
//            [me refreshTable];
            [self.navigationController popToViewController:me animated:YES];
        }
    }
    

}

-(void)didTableViewCellSelected:(UITableViewCell *)aCellData
{
    
    XXLog(@"%@",aCellData);
    
//            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(aCellData.tag==CellTypeChangeHead)
    {
        [self choseImage];
        
    }else if(aCellData.tag==CellTypeJumpController)
    {
        NSLog(@"12321321312");
        EditMessageController *edit=[[EditMessageController alloc]init];
        edit.cell=aCellData;
        edit.delegate=self;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:edit animated:YES];
    }else if (aCellData.tag==CellTypeNotDo)
    {
        
    }



}


-(void)choseImage
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
     UIAlertAction *Photos=[UIAlertAction actionWithTitle:@"照相" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         // 图片选择器
         UIImagePickerController *imgPC = [[UIImagePickerController alloc] init];
         
         //设置代理
         imgPC.delegate = self;
         imgPC.sourceType = UIImagePickerControllerSourceTypeCamera;
         //显示控制器
         [self presentViewController:imgPC animated:YES completion:nil];
         
         //允许编辑图片
         imgPC.allowsEditing = YES;
     }];
     UIAlertAction *takePhoto=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         // 图片选择器
         UIImagePickerController *imgPC = [[UIImagePickerController alloc] init];
         
         //设置代理
         imgPC.delegate = self;
         imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         //显示控制器
         [self presentViewController:imgPC animated:YES completion:nil];
         
         //允许编辑图片
         imgPC.allowsEditing = YES;

     }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Photos];
    [alert addAction:takePhoto];
     [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark 图片选择器的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    XXLog(@"____%@",info);
    
    //获取修改后的图片
    UIImage *editImage=info[UIImagePickerControllerEditedImage];
    imHead.image=editImage;
    [XMPPUser shareUser].headPhoto=UIImageJPEGRepresentation(editImage, 0.75);
    [[XMPPUser shareUser]saveUser];
     [self dismissViewControllerAnimated:YES completion:nil];
    //把新的图片保存到服务器
    [self editMessageController:nil didFinishSave:nil ];


}
#pragma mark 电子名片修改代理方法
-(void)editMessageController:(EditMessageController *)editVc didFinishSave:(id)sender
{
    

    
    XXLog(@"%@",editVc.cell.textLabel.text);
    XXLog(@"完成");
    //获取当前电子名片
    XMPPvCardTemp *myVCard = [XMPPTool sharedXMPPTool].vCard.myvCardTemp;
     XXLog(@"_______%@",[XMPPUser shareUser].headPhoto);
    
    if([editVc.cell.textLabel.text isEqualToString:@"昵称"])
    {
         myVCard.nickname=editVc.cell.detailTextLabel.text;
    
    }else
    {
        myVCard.nickname=[XMPPUser shareUser].nickname;
    
    }
    if([editVc.cell.textLabel.text isEqualToString:@"公司"])
    {
        myVCard.orgName=editVc.cell.detailTextLabel.text;
        
    }else
    {
     myVCard.orgName=[XMPPUser shareUser].orgName;
    }
    if([editVc.cell.textLabel.text isEqualToString:@"部门"])
    {
        myVCard.orgUnits=@[editVc.cell.detailTextLabel.text];
        
    }else
    {
        myVCard.orgUnits=@[[XMPPUser shareUser].orgUnits ];
    }
    if([editVc.cell.textLabel.text isEqualToString:@"职位"])
    {
        myVCard.title=editVc.cell.detailTextLabel.text;
        
    }else
    {
        myVCard.title=[XMPPUser shareUser].title;
    }
    if([editVc.cell.textLabel.text isEqualToString:@"电话"])
    {
        myVCard.note=editVc.cell.detailTextLabel.text;
        
    }else
    {
        myVCard.note=[XMPPUser shareUser].note;
    }
    if([editVc.cell.textLabel.text isEqualToString:@"邮件"])
    {
        myVCard.mailer=editVc.cell.detailTextLabel.text;
        
    }else
    {
        myVCard.mailer=[XMPPUser shareUser].mailer;
    }

    myVCard.photo= [XMPPUser shareUser].headPhoto;

    
        [[XMPPUser shareUser]saveUser];

         [[XMPPTool sharedXMPPTool].vCard updateMyvCardTemp:myVCard];
   
   
}

@end
