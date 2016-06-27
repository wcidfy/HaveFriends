//
//  EditMessageController.m
//  HaveFriends
//
//  Created by lxx on 16/6/12.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "EditMessageController.h"
#import "EditMessageView.h"
#import "PersonController.h"
@interface EditMessageController ()
@property(nonatomic,strong)EditMessageView *editMessageView;
@end

@implementation EditMessageController
-(void)loadView
{
    [super loadView];
    _editMessageView=[[EditMessageView alloc]init];
    self.view=_editMessageView;
   
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self buttonClicks];
     XXLog(@"___%@",_cell.textLabel.text);
    _editMessageView.textFild.text=_cell.detailTextLabel.text;
    _editMessageView.titleLable.text=_cell.textLabel.text;
}

-(void)buttonClicks
{
    [ _editMessageView.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [ _editMessageView.enterButton addTarget:self action:@selector(enterClick:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)cancelClick
{
    [self.navigationController popViewControllerAnimated:YES];
#pragma mark pop到指定页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[PersonController class]]) {
            PersonController *person=(PersonController *)controller;
            [self.navigationController popToViewController:person animated:YES];
        }
    }
}
#pragma mark 点击完成
-(void)enterClick:(id)sender
{
    self.cell.detailTextLabel.text=_editMessageView.textFild.text;
    [self.navigationController popViewControllerAnimated:YES];
    // 通知上一个控制器点击了button
    if ([self.delegate respondsToSelector:@selector(editMessageController:didFinishSave:)]) {
        [self.delegate editMessageController:self didFinishSave:sender];
    }

}
@end
